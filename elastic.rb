require 'elasticsearch'
require 'benchmark'

client = Elasticsearch::Client.new url: 'http://localhost:9200', log:true

#client.transport.reload_connections!
#client.cluster.health
#client.index index: 'addresses', type: 'address', body:{city: 'Praha', street: 'Ulcova'}

time1 = Benchmark.measure{
  #client.search index: 'addresses', body: {query: {match: {city:'Praha'}}}
  client.search index: 'addresses', body: {query:{multi_match: {query:'Ulčova 8 Praha 18400',
                                                                type: 'cross_fields',
                                                                operator: 'and',
                                                                fields: ['street_name', 'city', 'orientation_number', 'zip'],
                                                                 },

                                           }}
}

time2 = Benchmark.measure{
  client.search index: 'addresses', body: {query:{multi_match: {query:'Tachov',
                                                                type: 'cross_fields',
                                                                operator: 'and',
                                                                fields: ['city'],
                                                                },

  }}
}

time3 = Benchmark.measure{
  client.search index: 'addresses', body: {query:{multi_match: {query:'Plzeň',
                                                                type: 'cross_fields',
                                                                operator: 'and',
                                                                fields: ['city'],
  },

  }}
}
puts "Jedna konkretni adresa: #{time1.real}"
puts "Vsechny adresy Tachov: #{time2.real}"
puts "Vsechny adresy Plzen: #{time3.real}"

