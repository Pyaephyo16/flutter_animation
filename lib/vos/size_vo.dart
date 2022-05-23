class SizeVO {

  String? size;
  bool? isSelect;
  
  SizeVO({
    this.size,
    this.isSelect,
  });


  @override
  String toString() => 'SizeVO(size: $size, isSelect: $isSelect)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SizeVO &&
      other.size == size &&
      other.isSelect == isSelect;
  }

  @override
  int get hashCode => size.hashCode ^ isSelect.hashCode;
}
