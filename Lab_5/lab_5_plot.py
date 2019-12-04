import matplotlib.pyplot as plt
import csv

def plot_it(x,xlabl = '',ylabl = ''):
  plt.plot(x)
  plt.xlabel(xlabl)
  plt.ylabel(ylabl)
  plt.xlim(0,len(x))
  plt.show()


earn = []
earn_rel = []
contract_rel = []
contract = []
block_etc = 4.01352

for i in range(0,1000,200):
  with open('data'+str(i)+'.csv') as file:
      csv_reader = csv.reader(file,delimiter=',')
      for row in csv_reader:
          contract_rel.append(float(row[2])/float(row[1]))
          contract.append(float(row[2]))
          earn.append(float(row[0]))
          earn_rel.append(float(row[0])/block_etc)
plot_it(earn,ylabl="ETC")
plot_it(earn_rel,ylabl="ETC")
plot_it(contract,ylabl="contracts")
plot_it(contract_rel,ylabl="contracts")
