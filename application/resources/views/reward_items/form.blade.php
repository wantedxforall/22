<form method="POST" action="{{ route('reward-items.store') }}">
    @csrf
    <div>
        <label>Name</label>
        <input type="text" name="name" value="{{ old('name') }}">
    </div>
    <div>
        <label>Cost</label>
        <input type="number" name="cost" value="{{ old('cost') }}">
    </div>
    <div>
        <label>Quantity (optional)</label>
        <input type="number" name="quantity" value="{{ old('quantity') }}">
    </div>
    <div>
        <label>Delivery Method</label>
        <input type="text" name="delivery_method" value="{{ old('delivery_method') }}">
    </div>
    <button type="submit">Save</button>
</form>