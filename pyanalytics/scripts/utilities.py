#! usr/bin/env python

import kagglehub

def glimpse(df):
    print(f"Rows: {df.shape[0]}")
    print(f"Columns: {df.shape[1]}")
    for col in df.columns:
        print(f"$ {col} <{df[col].dtype}> {df[col].head().values}")

def kownload(src: str,
             dest: str | None = None,
             force: bool | None = True):
    src_path = kagglehub.dataset_download(handle=src, path=dest, force_download=force)
    print(f"Path to dataset files: {src_path}")

    return src_path