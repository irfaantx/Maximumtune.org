meta:
  id: xmd
  file-extension: bin
  title: XMD Archive
  endian: le
seq:
  - id: header
    type: xmd_header
  - id: positions
    type: u4
    repeat: expr
    repeat-expr: header.aligned_count
  - id: lengths
    type: u4
    repeat: expr
    repeat-expr: header.aligned_count
  - id: item_ids
    type: u4
    repeat: expr
    repeat-expr: header.aligned_count

types:
  xmd_header:
    seq:
      - id: magic
        contents: [0x58, 0x4d, 0x44, 0x00, 0x30, 0x30, 0x31, 0x00]
      - id: layout
        type: u4
        enum: list_counts
        valid:
          any-of:
            - list_counts::pos_len_id
      - id: count
        type: u4
    instances:
      aligned_count:
        value: count + ((4 - count) % 4)

enums:
  list_counts:
    3: pos_len_id
