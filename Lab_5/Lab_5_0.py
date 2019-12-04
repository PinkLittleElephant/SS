from web3.auto.infura import w3
import tqdm
import sys

K = 55
file_name = open('./data'+sys.argv[1]+'.csv','w')

for i in tqdm.tqdm(range(200), unit="block"):
  n = 8962400 - K*1000 + i + int(sys.argv[1])
  block = w3.eth.getBlock(n)
  used = block.gasUsed
  limit = block.gasLimit
  tax_m = 0
  contract = 0
  transactions_count =len(block.transactions)
  if transactions_count > 0:
      for tc in range(transactions_count):
          transaction = w3.eth.getTransactionByBlock(n,tc)
          if transaction.input != '0x':
              contract += 1
          price = transaction.gasPrice
          used = w3.eth.getTransactionReceipt(block.hash).gasUsed
          tax_m = tax_m + used*price;
      output = str(w3.fromWei(tax_m,'ether')) +","+str(transactions_count) +","+ str(contract)+'\n'
      file_name.write(output)

file_name.close()
