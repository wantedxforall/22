<?php

namespace App\Http\Controllers\Gateway\Paytm;

class PayTM{
    /*
     *  For PayTM
     */

    public function encrypt_e($input, $ky)
    {
        $key   = html_entity_decode($ky);
        $iv    = random_bytes(16);
        $data  = openssl_encrypt($input, "AES-128-CBC", $key, OPENSSL_RAW_DATA, $iv);
        return base64_encode($iv . $data);
    }

    public function decrypt_e($crypt, $ky)
    {
        $key   = html_entity_decode($ky);
        $data  = base64_decode($crypt);
        $iv    = substr($data, 0, 16);
        $crypt = substr($data, 16);
        return openssl_decrypt($crypt, "AES-128-CBC", $key, OPENSSL_RAW_DATA, $iv);
    }

    public function pkcs5_pad_e($text, $blocksize)
    {
        $pad = $blocksize - (strlen($text) % $blocksize);
        return $text . str_repeat(chr($pad), $pad);
    }
    public function pkcs5_unpad_e($text)
    {
        return $text;

        /*
        $pad = ord($text{
        strlen($text) - 1});
        if ($pad > strlen($text))
            return false;
        return substr($text, 0, -1 * $pad);
        */
    }

    public function generateSalt_e($length)
    {
        $data   = "AbcDE123IJKLMN67QRSTUVWXYZ";
        $data  .= "aBCdefghijklmn123opq45rs67tuv89wxyz";
        $data  .= "0FGH45OP89";
        $random = "";
        
        $max    = strlen($data) - 1;
        for ($i = 0; $i < $length; $i++) {
            $random .= $data[random_int(0, $max)];
        }
        return $random;
    }

    public function checkString_e($value)
    {
        $myvalue = ltrim($value);
        $myvalue = rtrim($myvalue);
        if ($myvalue == 'null')
            $myvalue = '';
        return $myvalue;
    }


    public function getChecksumFromArray($arrayList, $key, $sort = 1)
    {
        if ($sort != 0) {
            ksort($arrayList);
        }
        $str         = $this->getArray2Str($arrayList);
        $salt        = $this->generateSalt_e(4);
        $finalString = $str . "|" . $salt;
        $hash        = hash("sha256", $finalString);
        $hashString  = $hash . $salt;
        $checksum    = $this->encrypt_e($hashString, $key);
        return $checksum;
    }

    public function verifychecksum_e($arrayList, $key, $checksumvalue)
    {
        $arrayList = $this->removeCheckSumParam($arrayList);
        ksort($arrayList);
        $str        = $this->getArray2StrForVerify($arrayList);
        $paytm_hash = $this->decrypt_e($checksumvalue, $key);
        $salt       = substr($paytm_hash, -4);

        $finalString = $str . "|" . $salt;

        $website_hash = hash("sha256", $finalString);
        $website_hash .= $salt;

        $validFlag = "FALSE";
        if ($website_hash == $paytm_hash) {
            $validFlag = "TRUE";
        } else {
            $validFlag = "FALSE";
        }
        return $validFlag;
    }





    public function getArray2Str($arrayList)
    {
        $findme   = 'REFUND';
        $findmepipe = '|';
        $paramStr = "";
        $flag = 1;
        foreach ($arrayList as $key => $value) {
            $pos = strpos($value, $findme);
            $pospipe = strpos($value, $findmepipe);
            if ($pos !== false || $pospipe !== false) {
                continue;
            }

            if ($flag) {
                $paramStr .= $this->checkString_e($value);
                $flag = 0;
            } else {
                $paramStr .= "|" . $this->checkString_e($value);
            }
        }
        return $paramStr;
    }


    public function getArray2StrForVerify($arrayList)
    {
        $paramStr = "";
        $flag = 1;
        foreach ($arrayList as $key => $value) {
            if ($flag) {
                $paramStr .= $this->checkString_e($value);
                $flag = 0;
            } else {
                $paramStr .= "|" . $this->checkString_e($value);
            }
        }
        return $paramStr;
    }

    public function redirect2PG($paramList, $key)
    {
        $hashString = $this->getchecksumFromArray($paramList);
        $checksum   = $this->encrypt_e($hashString, $key);
    }

    public function removeCheckSumParam($arrayList)
    {
        if (isset($arrayList["CHECKSUMHASH"])) {
            unset($arrayList["CHECKSUMHASH"]);
        }
        return $arrayList;
    }

    public function getTxnStatus($requestParamList)
    {
        return $this->callAPI(PAYTM_STATUS_QUERY_URL, $requestParamList);
    }

    public function initiateTxnRefund($requestParamList)
    {
        $CHECKSUM                     = $this->getChecksumFromArray($requestParamList, PAYTM_MERCHANT_KEY, 0);
        $requestParamList["CHECKSUM"] = $CHECKSUM;
        return $this->callAPI(PAYTM_REFUND_URL, $requestParamList);
    }

    public function callAPI($apiURL, $requestParamList)
    {
        $jsonResponse      = "";
        $responseParamList = array();
        $JsonData          = json_encode($requestParamList);
        $postData          = 'JsonData=' . urlencode($JsonData);
        $ch                = curl_init($apiURL);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        $env = env('APP_ENV', 'production');
        if ($env === 'production') {
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
        } else {
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        }
        if ($ca = env('CUSTOM_CA_BUNDLE')) {
            curl_setopt($ch, CURLOPT_CAINFO, $ca);
        }

        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: application/json',
            'Content-Length: ' . strlen($postData)
        ));
        $jsonResponse      = curl_exec($ch);
        $responseParamList = json_decode($jsonResponse, true);
        return $responseParamList;
    }

    public function sanitizedParam($param)
    {
        $pattern[0]     = "%,%";
        $pattern[1]     = "%#%";
        $pattern[2]     = "%\(%";
        $pattern[3]     = "%\)%";
        $pattern[4]     = "%\{%";
        $pattern[5]     = "%\}%";
        $pattern[6]     = "%<%";
        $pattern[7]     = "%>%";
        $pattern[8]     = "%`%";
        $pattern[9]     = "%!%";
        $pattern[10]    = "%\\$%";
        $pattern[11]    = "%\%%";
        $pattern[12]    = "%\^%";
        $pattern[13]    = "%=%";
        $pattern[14]    = "%\+%";
        $pattern[15]    = "%\|%";
        $pattern[16]    = "%\\\%";
        $pattern[17]    = "%:%";
        $pattern[18]    = "%'%";
        $pattern[19]    = "%\"%";
        $pattern[20]    = "%;%";
        $pattern[21]    = "%~%";
        $pattern[22]    = "%\[%";
        $pattern[23]    = "%\]%";
        $pattern[24]    = "%\*%";
        $pattern[25]    = "%&%";
        $sanitizedParam = preg_replace($pattern, "", $param);
        return $sanitizedParam;
    }

    public function callNewAPI($apiURL, $requestParamList)
    {
        $jsonResponse = "";
        $responseParamList = array();
        $JsonData = json_encode($requestParamList);
        $postData = 'JsonData=' . urlencode($JsonData);
        $ch = curl_init($apiURL);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $env = env('APP_ENV', 'production');
        if ($env === 'production') {
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
        } else {
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        }
        if ($ca = env('CUSTOM_CA_BUNDLE')) {
            curl_setopt($ch, CURLOPT_CAINFO, $ca);
        }

        curl_setopt(
            $ch,
            CURLOPT_HTTPHEADER,
            array(
                'Content-Type: application/json',
                'Content-Length: ' . strlen($postData)
            )
        );
        $jsonResponse = curl_exec($ch);
        $responseParamList = json_decode($jsonResponse, true);
        return $responseParamList;
    }
}
