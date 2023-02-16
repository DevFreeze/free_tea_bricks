import '../../../core/utils/keys.dart';

class {{model_name.pascalCase()}} {
{{#properties}}final {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}} {{name}};{{/properties}}

const {{model_name.pascalCase()}}._({{#hasProperties}}{ {{#properties}}
this.{{name}},{{/properties}}
}{{/hasProperties}});

factory {{model_name.pascalCase()}}.empty() {
return const {{model_name.pascalCase()}}._();
}

{{> from_json }}
}

// TODO(FreeTea): Add the value(s) for the generated key(s) and then move them into keys.dart
// (delete if key(s) already exist(s))
{{#properties}}
const {{name}}Key = '';{{/properties}}
