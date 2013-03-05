# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
module Kafka
  class MultiProducer
    include Kafka::IO

    def initialize(options={})
      self.host = options[:host] || HOST
      self.port = options[:port] || PORT
      self.compression = options[:compression] || Message::NO_COMPRESSION
      self.connect(self.host, self.port)
    end

    def push(topic, messages, options={})
      partition = options[:partition] || 0
      self.write(Encoder.produce(topic, partition, messages, compression))
    end

    def multi_push(producer_requests)
      self.write(Encoder.multiproduce(producer_requests, compression))
    end
  end
end
