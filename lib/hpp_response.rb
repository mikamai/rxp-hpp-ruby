class HppResponse
  def hash(secret)
    @hash = generate_hash secret
    self
  end

  def generate_hash(secret)

    hash_result = [
      @timeStamp,
      @merchantId,
      @orderId,
      @result,
      @message,
      @pasRef,
      @authCode
    ].join(',')

    GenerationUtils.generateHash hash_result, secret
  end

  def apply_to_all(func)
    [
      @merchant_id,
      @account,
      @amount,
      @auth_code,
      @batch_id,
      @cavv,
      @cvn_result,
      @eci,
      @comment_one,
      @comment_two,
      @message,
      @pas_ref,
      @hash,
      @result,
      @xid,
      @order_id,
      @time_stamp
    ].each(func)
  end

  def encode
    apply_to_all(-> (field) { field = Base64.encode field })
    self
  end

  def decode(charset)
    apply_to_all(-> (field) { field = Base64.decode field })
    self
  end

  def hash_valid?(secret)
    generated_hash = generate_hash secret
    generated_hash == @hash
  end
end
