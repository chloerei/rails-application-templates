
class Sms

  def self.send_text(mobile, content)
    if ENV['SEND_REAL_SMS'] == 'false' or Rails.env != 'production'
      Rails.logger.info "sms debug: send sms to '#{mobile}' with '#{content}'"
      return {success: true, code: 0, message: 'send success'}
    end
    Rails.logger.info "sms do_send: send sms to '#{mobile}' with '#{content}'"
    ChinaSMS.to mobile, content
  end


  def self.send_verification_code(mobile, content, tpl_id=1)
    if ENV['SEND_REAL_SMS'] == 'false' or Rails.env != 'production'
      Rails.logger.info "sms debug: send sms to '#{mobile}' with '#{content}', and tpl_id = #{tpl_id}"
      return {success: true, code: 0, message: 'send success'}
    end
    Rails.logger.info "sms do_send: send sms to '#{mobile}' with '#{content}', and tpl_id = #{tpl_id}"
    ChinaSMS.to mobile, content, tpl_id: tpl_id
  end

end
