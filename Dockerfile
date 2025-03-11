# ビルド用ステージ
FROM public.ecr.aws/i1l4z0u0/morph-data:python${MORPH_PYTHON_VERSION} as builder

WORKDIR /build

# 依存関係のインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --target /build/dependencies

# ソースコードをコピー
COPY . /build

# 実行用ステージ（本番用イメージ）
FROM public.ecr.aws/i1l4z0u0/morph-data:python${MORPH_PYTHON_VERSION}

WORKDIR /var/task

# builderから必要な依存関係のみをコピー
COPY --from=builder /build/dependencies ${MORPH_PACKAGE_ROOT}
COPY --from=builder /build .

# 起動コマンド
CMD python "${MORPH_APP_FILE_PATH}"