# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:bionic

RUN apt-get update
RUN apt-get install -y pv wget curl

RUN wget -q https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh -O /demo-magic.sh
ADD demo.sh /demo.sh
CMD ["sleep", "9999999999"]
