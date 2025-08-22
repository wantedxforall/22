<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Acted By</th>
            <th>Acted At</th>
        </tr>
    </thead>
    <tbody>
    @foreach($rewardOrders as $order)
        <tr>
            <td>{{ $order->id }}</td>
            <td>{{ optional($order->actedBy)->name ?? 'N/A' }}</td>
            <td>{{ $order->acted_at }}</td>
        </tr>
    @endforeach
    </tbody>
</table>