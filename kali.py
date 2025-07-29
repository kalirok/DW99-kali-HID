def remove_data_before_magic(input_file, output_file=None):
    """
    删除指定魔术数字(1F 8B 08 00)之前的所有数据
    :param input_file: 输入文件名
    :param output_file: 输出文件名 (默认: 原文件名 + "_trimmed")
    """
    # 设置默认输出文件名
    if output_file is None:
        if '.' in input_file:
            name, ext = input_file.rsplit('.', 1)
            output_file = f"{name}_trimmed.{ext}"
        else:
            output_file = input_file + "_trimmed"
    
    # 要查找的魔术数字 (十六进制序列)
    magic_bytes = bytes.fromhex("1F 8B 08 00")
    
    try:
        with open(input_file, 'rb') as f:
            data = f.read()
    except FileNotFoundError:
        print(f"错误: 文件 '{input_file}' 不存在")
        return
    
    # 查找魔术数字位置
    magic_position = data.find(magic_bytes)
    
    if magic_position == -1:
        print(f"错误: 未找到魔术数字 {magic_bytes.hex(' ').upper()} 在文件中")
        return
    
    print(f"找到魔术数字在偏移量 0x{magic_position:X} (十进制位置: {magic_position})")
    
    # 保留魔术数字及之后的内容
    new_data = data[magic_position:]
    
    try:
        with open(output_file, 'wb') as f:
            f.write(new_data)
    except Exception as e:
        print(f"写入文件时出错: {e}")
        return
    
    print(f"已创建新文件: {output_file}")
    print(f"原始大小: {len(data)} 字节, 新大小: {len(new_data)} 字节")
    print(f"删除数据: {magic_position} 字节 (约 {magic_position/1024:.2f} KB)")

if __name__ == "__main__":
    import sys
    import os
    
    if len(sys.argv) < 2:
        print("用法: python script.py <输入文件> [输出文件]")
        print("示例: python trim_gzip_header.py corrupted.gz fixed.gz")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else None
    
    # 检查文件是否存在
    if not os.path.exists(input_file):
        print(f"错误: 文件 '{input_file}' 不存在")
        sys.exit(1)
    
    remove_data_before_magic(input_file, output_file)
    