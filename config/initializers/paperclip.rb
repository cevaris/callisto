Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
# Paperclip::Attachment.default_options[:path] = '/:id/:style/:filename'
# Paperclip::Attachment.default_options[:path] = ':id'