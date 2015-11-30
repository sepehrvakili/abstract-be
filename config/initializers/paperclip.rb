Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
## the old way: /posts/:id_partition/:style/:filename
Paperclip::Attachment.default_options[:path] = '/posts/:model/:user/:id_partition/:style/:filename'