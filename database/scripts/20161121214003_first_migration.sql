--
--    Copyright 2010-2016 the original author or authors.
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.
--

-- // First migration.
CREATE TABLE users (
  username VARCHAR(45) NOT NULL PRIMARY KEY,
  password VARCHAR(45) NOT NULL,
  enabled BOOL NOT NULL DEFAULT true
);

CREATE TABLE user_roles (
  user_role_id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(45) NOT NULL,
  role varchar(45) NOT NULL,
  UNIQUE KEY uni_username_role (role,username),
  KEY fk_username_idx (username),
  CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES users (username),
  PRIMARY KEY (user_role_id)
);

INSERT INTO users(username,password,enabled)
VALUES ('theuns','theuns', true);
INSERT INTO users(username,password,enabled)
VALUES ('user','user', true);
INSERT INTO users(username,password,enabled)
VALUES ('admin','admin', true);

INSERT INTO user_roles (username, role)
VALUES ('user', 'ROLE_USER');
INSERT INTO user_roles (username, role)
VALUES ('admin', 'ROLE_ADMIN');
INSERT INTO user_roles (username, role)
VALUES ('theuns', 'ROLE_USER');
INSERT INTO user_roles (username, role)
VALUES ('theuns', 'ROLE_ADMIN');

commit;

-- //@UNDO
DROP TABLE user_roles;
DROP TABLE users;

commit;