/* 
================================================================================
檔案代號:mraa_t
檔案名稱:保修週期設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mraa_t
(
mraaent       number(5)      ,/* 企業編號 */
mraa001       varchar2(10)      ,/* 保修週期編號 */
mraa002       varchar2(10)      ,/* 遇假日遞延/提前 */
mraa011       varchar2(1)      ,/* 一月 */
mraa012       varchar2(1)      ,/* 二月 */
mraa013       varchar2(1)      ,/* 三月 */
mraa014       varchar2(1)      ,/* 四月 */
mraa015       varchar2(1)      ,/* 五月 */
mraa016       varchar2(1)      ,/* 六月 */
mraa017       varchar2(1)      ,/* 七月 */
mraa018       varchar2(1)      ,/* 八月 */
mraa019       varchar2(1)      ,/* 九月 */
mraa020       varchar2(1)      ,/* 十月 */
mraa021       varchar2(1)      ,/* 十一月 */
mraa022       varchar2(1)      ,/* 十二月 */
mraa031       varchar2(1)      ,/* 第一週 */
mraa032       varchar2(1)      ,/* 第二週 */
mraa033       varchar2(1)      ,/* 第三週 */
mraa034       varchar2(1)      ,/* 第四週 */
mraa035       varchar2(1)      ,/* 第五週 */
mraa041       varchar2(1)      ,/* 星期一 */
mraa042       varchar2(1)      ,/* 星期二 */
mraa043       varchar2(1)      ,/* 星期三 */
mraa044       varchar2(1)      ,/* 星期四 */
mraa045       varchar2(1)      ,/* 星期五 */
mraa046       varchar2(1)      ,/* 星期六 */
mraa047       varchar2(1)      ,/* 星期日 */
mraa051       varchar2(1)      ,/* 1 */
mraa052       varchar2(1)      ,/* 2 */
mraa053       varchar2(1)      ,/* 3 */
mraa054       varchar2(1)      ,/* 4 */
mraa055       varchar2(1)      ,/* 5 */
mraa056       varchar2(1)      ,/* 6 */
mraa057       varchar2(1)      ,/* 7 */
mraa058       varchar2(1)      ,/* 8 */
mraa059       varchar2(1)      ,/* 9 */
mraa060       varchar2(1)      ,/* 10 */
mraa061       varchar2(1)      ,/* 11 */
mraa062       varchar2(1)      ,/* 12 */
mraa063       varchar2(1)      ,/* 13 */
mraa064       varchar2(1)      ,/* 14 */
mraa065       varchar2(1)      ,/* 15 */
mraa066       varchar2(1)      ,/* 16 */
mraa067       varchar2(1)      ,/* 17 */
mraa068       varchar2(1)      ,/* 18 */
mraa069       varchar2(1)      ,/* 19 */
mraa070       varchar2(1)      ,/* 20 */
mraa071       varchar2(1)      ,/* 21 */
mraa072       varchar2(1)      ,/* 22 */
mraa073       varchar2(1)      ,/* 23 */
mraa074       varchar2(1)      ,/* 24 */
mraa075       varchar2(1)      ,/* 25 */
mraa076       varchar2(1)      ,/* 26 */
mraa077       varchar2(1)      ,/* 27 */
mraa078       varchar2(1)      ,/* 28 */
mraa079       varchar2(1)      ,/* 29 */
mraa080       varchar2(1)      ,/* 30 */
mraa081       varchar2(1)      ,/* 31 */
mraa091       varchar2(1)      ,/* 時段一 */
mraa092       varchar2(8)      ,/* 時段一內容 */
mraa093       varchar2(1)      ,/* 時段二 */
mraa094       varchar2(8)      ,/* 時段二內容 */
mraa095       varchar2(1)      ,/* 時段三 */
mraa096       varchar2(8)      ,/* 時段三內容 */
mraa097       varchar2(1)      ,/* 時段四 */
mraa098       varchar2(8)      ,/* 時段四內容 */
mraa099       varchar2(1)      ,/* 時段五 */
mraa100       varchar2(8)      ,/* 時段五內容 */
mraa101       varchar2(1)      ,/* 時段六 */
mraa102       varchar2(8)      ,/* 時段六內容 */
mraaownid       varchar2(20)      ,/* 資料所有者 */
mraaowndp       varchar2(10)      ,/* 資料所屬部門 */
mraacrtid       varchar2(20)      ,/* 資料建立者 */
mraacrtdp       varchar2(10)      ,/* 資料建立部門 */
mraacrtdt       timestamp(0)      ,/* 資料創建日 */
mraamodid       varchar2(20)      ,/* 資料修改者 */
mraamoddt       timestamp(0)      ,/* 最近修改日 */
mraastus       varchar2(10)      ,/* 狀態碼 */
mraaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mraaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mraaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mraaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mraaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mraaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mraaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mraaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mraaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mraaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mraaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mraaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mraaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mraaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mraaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mraaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mraaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mraaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mraaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mraaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mraaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mraaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mraaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mraaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mraaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mraaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mraaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mraaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mraaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mraaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mraa_t add constraint mraa_pk primary key (mraaent,mraa001) enable validate;

create unique index mraa_pk on mraa_t (mraaent,mraa001);

grant select on mraa_t to tiptop;
grant update on mraa_t to tiptop;
grant delete on mraa_t to tiptop;
grant insert on mraa_t to tiptop;

exit;
