# credo:disable-for-this-file
[
  defmodule Demo3.Pbi.SearchRequest do
    @moduledoc false
    defstruct query: "", page_number: 0, results_per_page: 0, __uf__: []

    (
      (
        @spec encode(struct) :: {:ok, iodata} | {:error, any}
        def encode(msg) do
          try do
            {:ok, encode!(msg)}
          rescue
            e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
          end
        end

        @spec encode!(struct) :: iodata | no_return
        def encode!(msg) do
          []
          |> encode_query(msg)
          |> encode_page_number(msg)
          |> encode_results_per_page(msg)
          |> encode_unknown_fields(msg)
        end
      )

      []

      [
        defp encode_query(acc, msg) do
          try do
            if msg.query == "" do
              acc
            else
              [acc, "\n", Protox.Encode.encode_string(msg.query)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:query, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_page_number(acc, msg) do
          try do
            if msg.page_number == 0 do
              acc
            else
              [acc, "\x10", Protox.Encode.encode_int32(msg.page_number)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:page_number, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_results_per_page(acc, msg) do
          try do
            if msg.results_per_page == 0 do
              acc
            else
              [acc, "\x18", Protox.Encode.encode_int32(msg.results_per_page)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:results_per_page, "invalid field value"),
                      __STACKTRACE__
          end
        end
      ]

      defp encode_unknown_fields(acc, msg) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
          case wire_type do
            0 ->
              [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

            1 ->
              [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

            2 ->
              len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
              [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

            5 ->
              [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
          end
        end)
      end
    )

    (
      (
        @spec decode(binary) :: {:ok, struct} | {:error, any}
        def decode(bytes) do
          try do
            {:ok, decode!(bytes)}
          rescue
            e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
              {:error, e}
          end
        end

        (
          @spec decode!(binary) :: struct | no_return
          def decode!(bytes) do
            parse_key_value(bytes, struct(Demo3.Pbi.SearchRequest))
          end
        )
      )

      (
        @spec parse_key_value(binary, struct) :: struct
        defp parse_key_value(<<>>, msg) do
          msg
        end

        defp parse_key_value(bytes, msg) do
          {field, rest} =
            case Protox.Decode.parse_key(bytes) do
              {0, _, _} ->
                raise %Protox.IllegalTagError{}

              {1, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
                {[query: Protox.Decode.validate_string!(delimited)], rest}

              {2, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int32(bytes)
                {[page_number: value], rest}

              {3, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int32(bytes)
                {[results_per_page: value], rest}

              {tag, wire_type, rest} ->
                {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

                {[
                   {msg.__struct__.unknown_fields_name(),
                    [value | msg.__struct__.unknown_fields(msg)]}
                 ], rest}
            end

          msg_updated = struct(msg, field)
          parse_key_value(rest, msg_updated)
        end
      )

      []
    )

    (
      @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
      def json_decode(input, opts \\ []) do
        try do
          {:ok, json_decode!(input, opts)}
        rescue
          e in Protox.JsonDecodingError -> {:error, e}
        end
      end

      @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
      def json_decode!(input, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

        Protox.JsonDecode.decode!(
          input,
          Demo3.Pbi.SearchRequest,
          &json_library_wrapper.decode!(json_library, &1)
        )
      end

      @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
      def json_encode(msg, opts \\ []) do
        try do
          {:ok, json_encode!(msg, opts)}
        rescue
          e in Protox.JsonEncodingError -> {:error, e}
        end
      end

      @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
      def json_encode!(msg, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
        Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
      end
    )

    (
      @deprecated "Use fields_defs()/0 instead"
      @spec defs() :: %{
              required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs() do
        %{
          1 => {:query, {:scalar, ""}, :string},
          2 => {:page_number, {:scalar, 0}, :int32},
          3 => {:results_per_page, {:scalar, 0}, :int32}
        }
      end

      @deprecated "Use fields_defs()/0 instead"
      @spec defs_by_name() :: %{
              required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs_by_name() do
        %{
          page_number: {2, {:scalar, 0}, :int32},
          query: {1, {:scalar, ""}, :string},
          results_per_page: {3, {:scalar, 0}, :int32}
        }
      end
    )

    (
      @spec fields_defs() :: list(Protox.Field.t())
      def fields_defs() do
        [
          %{
            __struct__: Protox.Field,
            json_name: "query",
            kind: {:scalar, ""},
            label: :optional,
            name: :query,
            tag: 1,
            type: :string
          },
          %{
            __struct__: Protox.Field,
            json_name: "pageNumber",
            kind: {:scalar, 0},
            label: :optional,
            name: :page_number,
            tag: 2,
            type: :int32
          },
          %{
            __struct__: Protox.Field,
            json_name: "resultsPerPage",
            kind: {:scalar, 0},
            label: :optional,
            name: :results_per_page,
            tag: 3,
            type: :int32
          }
        ]
      end

      [
        @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
        (
          def field_def(:query) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "query",
               kind: {:scalar, ""},
               label: :optional,
               name: :query,
               tag: 1,
               type: :string
             }}
          end

          def field_def("query") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "query",
               kind: {:scalar, ""},
               label: :optional,
               name: :query,
               tag: 1,
               type: :string
             }}
          end

          []
        ),
        (
          def field_def(:page_number) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "pageNumber",
               kind: {:scalar, 0},
               label: :optional,
               name: :page_number,
               tag: 2,
               type: :int32
             }}
          end

          def field_def("pageNumber") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "pageNumber",
               kind: {:scalar, 0},
               label: :optional,
               name: :page_number,
               tag: 2,
               type: :int32
             }}
          end

          def field_def("page_number") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "pageNumber",
               kind: {:scalar, 0},
               label: :optional,
               name: :page_number,
               tag: 2,
               type: :int32
             }}
          end
        ),
        (
          def field_def(:results_per_page) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "resultsPerPage",
               kind: {:scalar, 0},
               label: :optional,
               name: :results_per_page,
               tag: 3,
               type: :int32
             }}
          end

          def field_def("resultsPerPage") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "resultsPerPage",
               kind: {:scalar, 0},
               label: :optional,
               name: :results_per_page,
               tag: 3,
               type: :int32
             }}
          end

          def field_def("results_per_page") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "resultsPerPage",
               kind: {:scalar, 0},
               label: :optional,
               name: :results_per_page,
               tag: 3,
               type: :int32
             }}
          end
        ),
        def field_def(_) do
          {:error, :no_such_field}
        end
      ]
    )

    (
      @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
      def unknown_fields(msg) do
        msg.__uf__
      end

      @spec unknown_fields_name() :: :__uf__
      def unknown_fields_name() do
        :__uf__
      end

      @spec clear_unknown_fields(struct) :: struct
      def clear_unknown_fields(msg) do
        struct!(msg, [{unknown_fields_name(), []}])
      end
    )

    (
      @spec required_fields() :: []
      def required_fields() do
        []
      end
    )

    (
      @spec syntax() :: atom()
      def syntax() do
        :proto3
      end
    )

    [
      @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
      def default(:query) do
        {:ok, ""}
      end,
      def default(:page_number) do
        {:ok, 0}
      end,
      def default(:results_per_page) do
        {:ok, 0}
      end,
      def default(_) do
        {:error, :no_such_field}
      end
    ]

    (
      @spec file_options() :: nil
      def file_options() do
        nil
      end
    )
  end
]
