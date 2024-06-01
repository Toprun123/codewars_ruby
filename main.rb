#!/usr/bin/env ruby




def next_smaller(n)

end

puts next_smaller(531) # 513



def alphabet_position(t)t.downcase.gsub(/[^a-z]/,"").codepoints.map{|e|e-96}.join(" ")end

p alphabet_position("The sunset sets at twelve o' clock.")



def ipsBetween(s,e,x=s.split('.'),y=e.split('.'),g=false,p=0)
    for i in 0..3 do if x[i]!=y[i]||g;g=!g;p+=(y[i].to_i-x[i].to_i)*256**(3-i);end end
    p
end

p ipsBetween("20.0.0.10", "20.0.1.0") # 246

def decode(x)
    e="bdhpF,82QsLirJejtNmzZKgnB3SwTyXG ?.6YIcflxVC5WE94UA1OoD70MkvRuPqHa"*2;ls={};r="";
    y=%w(, . ?).push(*'a'..'z',*'A'..'Z',*'0'..'9',' ');y.each do|l|ls[l]=e[e.index(l)+1..e.index(l)+66]end
    for i in 0..x.length-1;if y.include?(x[i]);r+=ls[x[i]][64-i];else;r+=x[i];end;end;r
end

def encode(x)
    e="bdhpF,82QsLirJejtNmzZKgnB3SwTyXG ?.6YIcflxVC5WE94UA1OoD70MkvRuPqHa"*2;ls={};r="";
    y=['?','.',' ',','].push(*'a'..'z',*'A'..'Z',*'0'..'9');y.each do|l|ls[l]=e[e.index(l)+1..e.index(l)+66]end
    for i in 0..x.length-1;if y.include?(x[i]);r+=ls[x[i]][i];else;r+=x[i];end;end;r
end

coded = encode("Hello World!")
puts decode(coded), coded


def duplicate_encode(i,w=i.downcase)w.chars.map{|c|w.count(c)>1?')':'('}.join()end

p duplicate_encode("Success")   #  )())())
p duplicate_encode("(( @")      #  ))((



def ip_to_int32(i)i.split('.').map{|e|e.to_i.to_s(2).rjust(8,'0')}.join.to_i(2)end

p ip_to_int32("128.114.17.104") # 2154959208
p ip_to_int32("128.32.10.1")    # 2149583361



def smallest(n,x=n.to_s.split("",-1).map{|e|e.to_i},all=[])
    x.pop
    for e,i in x.each_with_index do for l,j in x.each_with_index
        y=x.map(&:clone);y.delete_at i;y.insert j,e
        all<<[y.join.to_i, i, j]
    end end
    all.min
end

p smallest 261235 # [126235, 2, 0]
p smallest 209917 # [29917, 0, 1]
p smallest 296837 # [239687, 4, 1]


def parse_int(s)
    n={"zero"=>0,"one"=>1,"two"=>2,"three"=>3,"four"=>4,"five"=>5,"six"=>6,"seven"=>7,"eight"=>8,"nine"=>9,
        "eleven"=>11,"twelve"=>12,"thirteen"=>13,"fourteen"=>14,"fifteen"=>15,"sixteen"=>16,"seventeen"=>17,"eighteen"=>18,"nineteen"=>19,
        "ten"=>10,"twenty"=>20,"thirty"=>30,"forty"=>40,"fifty"=>50,"sixty"=>60,"seventy"=>70,"eighty"=>80,"ninety"=>90,
        "hundred"=>false,"thousand"=>false,"million"=>false}; b={"hundred"=>100,"thousand"=>1000,"million"=>1000000}
    s.split(/(?<=thousand|million)/).reverse.map{|e|e.split(/ and | |-/).inject(0){|r,i|i!=''? n[i]? r+n[i]: r*b[i]: r}}.reverse.reduce(:+)
end

p parse_int("six million seven hundred eighty-three thousand nine hundred and nineteen")
p parse_int("two thousand")



def pig_it(t)
    t.split(" ").map{|e|e[1..-1]+e[0]+(e.chars.all?{|c|c=~/[a-zA-Z]/}? "ay": "")}.join(' ')
end

p pig_it("Hello World !")



def first_non_repeating_letter(s)s.chars.inject(""){|c,n|if s.downcase.count(n.downcase)==1;return n end}||"" end

p first_non_repeating_letter("GImQIfin")



def solution(_r,r=_r.split(''))
    r.pop
    nums = {
        "M" => 1_000,
        "D" => 500,
        "C" => 100,
        "L" => 50,
        "X" => 10,
        "V" => 5,
        "I" => 1
    }
    res = 0
    x = 1_000
    for e in r
        if nums[e] <= x
            res += nums[e]
            x = nums[e]
        elsif nums[e] > x
            res -= nums[e]
        end
    end
    return res.abs
end


p solution('XXI')         # 21
p solution('I')           # 1
p solution('IV')          # 4
p solution('MMVIII')      # 2008
p solution('MDCLXVI')     # 1666

def simplify(x,ts=x.split(/(?=[+-])/),s="",vs={})
    ts.each do |e|
        h=e.match(/\d+/);c=(h ?h[0].to_i: 1)*(e[0]=="-"?-1:1)
        v=e.match(/[a-z]+/).to_s.split("").sort.join;vs[v]=vs[v]?vs[v]+c:c
    end
    vs.sort.to_h.sort_by{|a,b|a.length}.to_h
            .each{|k,c|s+=c==0?"":(c==1?"+#{k}":(c==-1?"-#{k}":(c<0?"#{c}#{k}":"+#{c}#{k}")))}
    s[0]=="+"?s[1..-1]:s
end

pp simplify("4yxz-2xy+3xy")
pp simplify("-a+5ab+3a-c-2a")



$draw = ->(x){x.map{|y|y.map{|z|z==1? "██" : "  "}.join}}

def spiralize(x)
    a=Array.new(x){Array.new(x){0}};xj=1;g=pg=ps=0;
    r=->x{x.transpose.map(&:reverse)}
    while xj<=x+3
        ps=pg;i=ps;pg=g;if xj%4==0;g+=2;end
        while i<x-g;a[x-1-pg][i]=1;i+=1;end
        a=r.(a);xj+=1
    end
    while !a[0].include?(0);a=r.(a);end
    if x%2==0;a[x/2-1][x/2]=0;end
    return r.(a).map{|x|x.reverse}
end

puts
puts $draw.(spiralize(20))


class Sudoku
    def initialize(d)
        @d=d;@N=@d.length
        @r=Math.sqrt(@N)
    end
    def valid?
        begin;a=*(1..@N)
        for i in 0..@N-1
            if @d[i].sort!=a;return false end
            if @d.transpose[i].sort!=a;return false end
        end
        for b in 0..@r-1; for c in 0..@r-1
            if @d[b*@r...(b*@r)+@r].map{|r|r[c*@r...(c*@r)+@r]}.flatten.sort!=a;return false end
        end end
        return @r!=@r.to_i()?false:true
        rescue; return false end
    end
end

badSudoku1 = Sudoku.new([
    [0,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9]
])

gs1 = Sudoku.new([
    [7,8,4, 1,5,9, 3,2,6],
    [5,3,9, 6,7,2, 8,4,1],
    [6,1,2, 4,3,8, 7,5,9],
    [9,2,8, 7,1,5, 4,6,3],
    [3,5,7, 8,4,6, 1,9,2],
    [4,6,1, 9,2,3, 5,8,7],
    [8,7,6, 3,9,4, 2,1,5],
    [2,4,3, 5,6,1, 9,7,8],
    [1,9,5, 2,8,7, 6,3,4]
])

pp badSudoku1.valid? , gs1.valid?

def moveZeros(a)a.select{|e|e!=0}+Array.new(a.count(0),0)end

p moveZeros([1,2,0,1,0,1,0,3,0,1])



__END__
