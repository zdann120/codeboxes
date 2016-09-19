module Api
  class Query
    BoxType = GraphQL::ObjectType.define do
      name "Box"
      description "A code box"

      field :id, !types.ID
      field :title, !types.String
    end


    QueryType = GraphQL::ObjectType.define do
      name "Query"
      description "The query root of this schema"

      field :box do
        type BoxType
        argument :id, !types.ID
        resolve -> (obj, args, ctx) { Box.find(args["id"]) }
      end
    end

    Schema = GraphQL::Schema.define do
      query QueryType
      max_depth 8
    end
  end
end