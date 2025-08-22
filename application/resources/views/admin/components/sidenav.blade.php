<div class="sidebar">
    <button class="res-sidebar-close-btn"><i class="las la-times"></i></button>
    <div class="sidebar__inner">
        <div class="sidebar__logo">
            <a href="{{route('admin.dashboard')}}" class="sidebar__main-logo"><img
                    src="{{getImage(getFilePath('logoIcon') .'/logo.png')}}" alt="@lang('image')"></a>
        </div>

        <div class="sidebar__menu-wrapper" id="sidebar__menuWrapper">
            <ul class="sidebar__menu">
                <li class="sidebar-menu-item {{menuActive('admin.dashboard')}}">
                    <a href="{{route('admin.dashboard')}}" class="nav-link ">
                        <i class="menu-icon las la-chart-line"></i>
                        <span class="menu-title">@lang('Dashboard')</span>
                    </a>
                </li>
                <li class="sidebar__menu-header">@lang('Users Management')</li>
                <li class="sidebar-menu-item {{menuActive('admin.users.*')}}">
                    <a href="{{route('admin.users.active')}}" class="nav-link ">
                        <i class="menu-icon las la-user"></i>
                        <span class="menu-title">@lang('All Users')</span>
                        @if($bannedUsersCount > 0 || $emailUnverifiedUsersCount > 0 || $mobileUnverifiedUsersCount > 0)
                        <div class="blob white"></div>
                        @endif
                    </a>
                </li>
                <li class="sidebar-menu-item  {{menuActive('admin.subscriber.*')}}">
                    <a href="{{route('admin.subscriber.index')}}" class="nav-link"
                        data-default-url="{{ route('admin.subscriber.index') }}">
                        <i class="menu-icon las la-envelope"></i>
                        <span class="menu-title">@lang('Subscribers') </span>
                    </a>
                </li>

                <li class="sidebar-menu-item  {{menuActive('admin.plan.*')}}">
                    <a href="{{route('admin.plan.index')}}" class="nav-link"
                        data-default-url="{{ route('admin.plan.index') }}">
                        <i class="menu-icon las la-gift menu-icon"></i>
                        <span class="menu-title">@lang('Plans') </span>
                    </a>
                </li>
				
				<li class="sidebar-menu-item  {{menuActive('admin.levels.*')}}">
                    <a href="{{ route('admin.levels.index') }}" class="nav-link" data-default-url="{{ route('admin.levels.index') }}">
                        <i class="menu-icon las la-layer-group"></i>
                        <span class="menu-title">@lang('Levels')</span>
                    </a>
                </li>

                <li class="sidebar-menu-item {{ request()->routeIs('admin.benefit-overrides.*') ? 'active' : '' }}">
                <a href="{{ route('admin.benefit-overrides.index') }}">
                    <i class="menu-icon las la-gift"></i>
                    <span>@lang('Benefit Overrides')</span>
                </a>
            </li>

                <li class="sidebar__menu-header">@lang('Promotion Post Management')</li>
                <li class="sidebar-menu-item  {{menuActive('admin.category.*')}}">
                    <a href="{{route('admin.category.index')}}" class="nav-link"
                        data-default-url="{{ route('admin.category.index') }}">
                        <i class="menu-icon las la-list"></i>
                        <span class="menu-title">@lang('Categories') </span>
                    </a>
                </li>

                <li class="sidebar-menu-item  {{menuActive('admin.service.index')}}">
                    <a href="{{route('admin.service.index')}}" class="nav-link"
                        data-default-url="{{ route('admin.service.index') }}">
                        <i class="menu-icon fa-solid fa-signs-post"></i>
                        <span class="menu-title">@lang('Promotion Post') </span>
                        @if(0 < $pendingPost)
                            <div class="blob white"></div>
                        @endif
                    </a>
                </li>

                <li class="sidebar-menu-item  {{menuActive('admin.service.report')}}">
                    <a href="{{route('admin.service.report')}}" class="nav-link"
                        data-default-url="{{ route('admin.service.report') }}">
                        <i class="menu-icon fa-solid fa-signs-post"></i>
                        <span class="menu-title">@lang('Report Post') </span>
                    </a>
                </li>



                <li class="sidebar-menu-item  {{ menuActive('admin.refferal.*') }}">
                    <a href="{{ route('admin.refferal.index') }}" class="nav-link"
                        data-default-url="{{ route('admin.refferal.index') }}">
                        <i class="menu-icon las la-percent"></i>
                        <span class="menu-title">@lang('Manage Refferal')</span>

                    </a>
                </li>
				
				<li class="sidebar__menu-header">@lang('Reward')</li>
				<li class="sidebar-menu-item {{ menuActive('admin.reward-items.*') }}">
                    <a href="{{ route('admin.reward-items.index') }}" class="nav-link">
                        <i class="menu-icon las la-gift"></i>
                        <span class="menu-title">@lang('Reward Items')</span>
                    </a>
                </li>
				<li class="sidebar-menu-item {{ menuActive('admin.reward-categories.*') }}">
				  <a href="{{ route('admin.reward-categories.index') }}" class="nav-link">
				  <i class="menu-icon las la-gift"></i>
					<span class="menu-title">@lang('Reward Categories')</span>
				  </a>
				</li>
                <li class="sidebar-menu-item {{ menuActive('admin.reward-orders.*') }}">
                    <a href="{{ route('admin.reward-orders.index') }}" class="nav-link">
                        <i class="menu-icon las la-shopping-bag"></i>
                        <span class="menu-title">@lang('Reward Orders')</span>
                    </a>
                </li>

                <li class="sidebar__menu-header">@lang('Transactions')</li>
                <li class="sidebar-menu-item {{menuActive('admin.deposit.*')}}">
                    <a href="{{route('admin.deposit.pending')}}" class="nav-link ">
                        <i class="menu-icon las la-wallet"></i>
                        <span class="menu-title">@lang('Deposits')</span>
                        @if(0 < $pendingDepositsCount)
                            <div class="blob white"></div>
                        @endif
                    </a>
                </li>
                <li class="{{menuActive('admin.withdraw.*')}}">
                    <a href="{{route('admin.withdraw.index')}}" class="nav-link">
                        <i class="menu-icon las la-money-bill-wave"></i>
                        <span class="menu-title">@lang('Withdraw Requests')</span>
                    </a>
                </li>
        <li class="sidebar-menu-item {{menuActive('admin.gateway.*')}}">
            <a href="{{route('admin.gateway.automatic.index')}}" class="nav-link ">
                <i class="menu-icon las la-dollar-sign"></i>
                <span class="menu-title">@lang('Payment Gateways')</span>
            </a>
        </li>

    <li class="sidebar__menu-header">@lang('Report')</li>
    <li class="sidebar-menu-item {{menuActive(['admin.report.transaction','admin.report.transaction.search'])}}">
        <a href="{{route('admin.report.transaction')}}" class="nav-link">
            <i class="menu-icon las la-credit-card"></i>
            <span class="menu-title">@lang('Transactions')</span>
        </a>
    </li>
    <li class="sidebar-menu-item {{menuActive(['admin.report.login.history','admin.report.login.ipHistory'])}}">
        <a href="{{route('admin.report.login.history')}}" class="nav-link">
            <i class="menu-icon las la-sign-in-alt"></i>
            <span class="menu-title">@lang('Login Activities')</span>
        </a>
    </li>
    <li class="sidebar-menu-item {{menuActive('admin.report.notification.history')}}">
        <a href="{{route('admin.report.notification.history')}}" class="nav-link">
            <i class="menu-icon las la-bell"></i>
            <span class="menu-title">@lang('Notifications')</span>
        </a>
    </li>
    <li class="sidebar__menu-header">@lang('Help Desk')</li>
    <li class="sidebar-menu-item {{menuActive('admin.ticket.*')}}">
        <a href="{{route('admin.ticket.pending')}}" class="nav-link ">
            <i class="menu-icon las la la-life-ring"></i>
            <span class="menu-title">@lang('Support Ticket')</span>
            @if(0 < $pendingTicketCount) <div class="blob white">
</div>@endif
</a>
</li>
<li class="sidebar__menu-header">@lang('Content Management')</li>

<li class="sidebar-menu-item {{menuActive('admin.frontend.manage.*')}}">
    <a href="{{route('admin.frontend.manage.pages')}}" class="nav-link ">
        <i class="menu-icon la la-pager"></i>
        <span class="menu-title">@lang('Pages')</span>
    </a>
</li>

<li class="sidebar-menu-item sidebar-dropdown">
    <a href="javascript:void(0)" class="{{menuActive('admin.frontend.sections*',3)}}">
        <i class="menu-icon la la-grip-horizontal"></i>
        <span class="menu-title">@lang('Sections')</span>
    </a>
    <div class="sidebar-submenu {{menuActive('admin.frontend.sections*',2)}} ">
        <ul>
            @php
            $lastSegment = collect(request()->segments())->last();
            @endphp
            @foreach(getPageSections(true) as $k => $secs)
            @if($secs['builder'])
            <li class="sidebar-menu-item  @if($lastSegment == $k) active @endif ">
                <a href="{{ route('admin.frontend.sections',$k) }}" class="nav-link">
                    <i class="menu-icon las la-caret-right"></i>
                    <span class="menu-title">{{__($secs['name'])}}</span>
                </a>
            </li>
            @endif
            @endforeach
        </ul>
    </div>
</li>
<li class="sidebar__menu-header">@lang('General Settings')</li>

<li class="sidebar-menu-item {{menuActive('admin.setting.index')}}">
    <a href="{{route('admin.setting.index')}}" class="nav-link">
        <i class="menu-icon las la-globe"></i>
        <span class="menu-title">@lang('Global Settings')</span>
    </a>
</li>
<li class="sidebar-menu-item {{ menuActive('admin.twofactor') }}">
       <a href="{{ route('admin.twofactor') }}" class="nav-link">
           <i class="menu-icon las la-shield-alt"></i>
           <span class="menu-title">@lang('Two Factor')</span>
       </a>
   </li>
<li class="sidebar-menu-item {{menuActive('admin.setting.logo.icon')}}">
    <a href="{{route('admin.setting.logo.icon')}}" class="nav-link">
        <i class="menu-icon las la-image"></i>
        <span class="menu-title">@lang('Logo & Favicon')</span>
    </a>
</li>
<li class="sidebar-menu-item  {{menuActive(['admin.language.manage','admin.language.key'])}}">
    <a href="{{route('admin.language.manage')}}" class="nav-link"
        data-default-url="{{ route('admin.language.manage') }}">
        <i class="menu-icon las la-language"></i>
        <span class="menu-title">@lang('Language') </span>
    </a>
</li>
<li class="sidebar-menu-item sidebar-dropdown">
    <a href="javascript:void(0)" class="{{menuActive('admin.setting.notification*',3)}}">
        <i class="menu-icon las la-bell"></i>
        <span class="menu-title">@lang('Email & Notification')</span>
    </a>
    <div class="sidebar-submenu {{menuActive('admin.setting.notification*',2)}} ">
        <ul>
            <li class="sidebar-menu-item {{menuActive('admin.setting.notification.templates')}} ">
                <a href="{{route('admin.setting.notification.templates')}}" class="nav-link">
                    <i class="menu-icon las la-caret-right"></i>
                    <span class="menu-title">@lang('All Templates')</span>
                </a>
            </li>
            <li class="sidebar-menu-item {{menuActive('admin.setting.notification.global')}} ">
                <a href="{{route('admin.setting.notification.global')}}" class="nav-link">
                    <i class="menu-icon las la-caret-right"></i>
                    <span class="menu-title">@lang('Global Template')</span>
                </a>
            </li>
            <li class="sidebar-menu-item {{menuActive('admin.setting.notification.email')}} ">
                <a href="{{route('admin.setting.notification.email')}}" class="nav-link">
                    <i class="menu-icon las la-caret-right"></i>
                    <span class="menu-title">@lang('Email Config')</span>
                </a>
            </li>
            <li class="sidebar-menu-item {{menuActive('admin.setting.notification.sms')}} ">
                <a href="{{route('admin.setting.notification.sms')}}" class="nav-link">
                    <i class="menu-icon las la-caret-right"></i>
                    <span class="menu-title">@lang('SMS Config')</span>
                </a>
            </li>
        </ul>
    </div>
</li>
<li class="sidebar-menu-item {{menuActive('admin.extensions.index')}}">
    <a href="{{route('admin.extensions.index')}}" class="nav-link">
        <i class="menu-icon las la-cogs"></i>
        <span class="menu-title">@lang('Plugins')</span>
    </a>
</li>
<li class="sidebar-menu-item {{menuActive('admin.seo')}}">
    <a href="{{route('admin.seo')}}" class="nav-link">
        <i class="menu-icon las la-project-diagram"></i>
        <span class="menu-title">@lang('SEO')</span>
    </a>
</li>
<li class="sidebar-menu-item {{menuActive('admin.setting.cookie')}}">
    <a href="{{route('admin.setting.cookie')}}" class="nav-link">
        <i class="menu-icon las la-check-circle"></i>
        <span class="menu-title">@lang('GDPR Policy')</span>
    </a>
</li>
<li class="sidebar-menu-item {{menuActive('admin.api.setting')}}">
    <a href="{{route('admin.api.setting')}}" class="nav-link">
        <i class="menu-icon las la-key"></i>
        <span class="menu-title">@lang('API Settings')</span>
    </a>
</li>
<li class="sidebar-menu-item {{menuActive('admin.apify.index')}}">
    <a href="{{route('admin.apify.index')}}" class="nav-link">
        <i class="menu-icon las la-robot"></i>
        <span class="menu-title">@lang('Apify')</span>
    </a>
</li>
<li class="sidebar-menu-item {{ menuActive('admin.setting.custom.css') }}">
    <a href="{{ route('admin.setting.custom.css') }}" class="nav-link">
        <i class="menu-icon lab la-css3-alt"></i>
        <span class="menu-title">@lang('Custom CSS')</span>
    </a>
</li>

<li class="sidebar-menu-item">
    <a href="{{ route('admin.clear.cache') }}" class="nav-link">
        <i class="menu-icon las la-broom"></i>
        <span class="menu-title">@lang('Clear Cache')</span>
    </a>
</li>
<li class="sidebar-menu-item">
    <a href="javascript:void(0)" class="nav-link">
        <i class="menu-icon las la-code-branch"></i>
        <span class="menu-title">@lang('Panel') {{ sysInfo()['admin_version'] }}</span>
    </a>
</li>

</ul>
</div>
</div>
</div>
<!-- sidebar end -->



@push('script')
<script>
(function () {
  var wrapper = document.getElementById('sidebar__menuWrapper');
  if (!wrapper) return;

  // 1) أوقف أي أنيميشنات متراكمة على نفس العنصر ممكن توقف العجلة
  if (window.jQuery) {
    jQuery(wrapper).stop(true, true);
  }

  // 2) Scroll to active بدون animate (لمنع تجميد العجلة)
  function scrollToActive(){
    var active = wrapper.querySelector('li.active');
    if (!active) return;

    var wRect = wrapper.getBoundingClientRect();
    var aRect = active.getBoundingClientRect();
    var relativeTop = aRect.top - wRect.top;

    var target = wrapper.scrollTop + relativeTop - 320;
    if (target < 0) target = 0;

    wrapper.scrollTo({ top: target, behavior: 'auto' });
  }

  // نفّذ بعد اكتمال التحميل + إعادة قصيرة لتثبيت القياسات بعد تحميل أي صور
  if (document.readyState === 'complete') {
    scrollToActive(); setTimeout(scrollToActive, 250);
  } else {
    window.addEventListener('load', function(){
      scrollToActive(); setTimeout(scrollToActive, 250);
    });
  }

  // 3) “تفريغ” سريع يعيد تهيئة محرّك التمرير ببعض المتصفحات
  wrapper.style.overflowY = 'hidden';
  // إجبار إعادة تدفق
  void wrapper.offsetHeight;
  wrapper.style.overflowY = 'auto';

  // 4) معالج wheel يضمن أن الحدث يُستهلك هنا إذا كان يمكن التمرير فعلاً
  wrapper.addEventListener('wheel', function(e){
    var before = this.scrollTop;
    // لا تغيّر كثيرًا؛ فقط جرّب لو في مجال للتمرير
    this.scrollTop = before + (e.deltaY || 0);
    var after = this.scrollTop;

    // إذا حدث تمرير فعلاً، امنع انتقال الحدث للصفحة
    if (after !== before) {
      e.preventDefault();
      e.stopPropagation();
    }
  }, { passive: false });

  // 5) إن وُجد overlay مخفي فوق السايدبار، عطّل التقاطه للأحداث وهو مخفي
  // (أحياناً عناصر :after أو overlays تبقى بمكانها مع opacity:0)
  ['.sidebar-overlay', '.sidebar__inner:after'].forEach(function(sel){
    try{
      var els = document.querySelectorAll(sel);
      els.forEach(function(el){
        var cs = getComputedStyle(el);
        var hidden = (cs.display === 'none') || (cs.visibility === 'hidden') || (parseFloat(cs.opacity) === 0);
        if (hidden) el.style.pointerEvents = 'none';
      });
    }catch(_){}
  });
})();
</script>
@endpush
