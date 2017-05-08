/* 
================================================================================
檔案代號:isag_t
檔案名稱:銷項發票來源明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isag_t
(
isagent       number(5)      ,/* 企業編號 */
isagcomp       varchar2(10)      ,/* 法人 */
isagdocno       varchar2(20)      ,/* 開票單號 */
isagseq       number(10,0)      ,/* 項次 */
isagorga       varchar2(10)      ,/* 來源組織 */
isag001       varchar2(20)      ,/* 來源類型 */
isag002       varchar2(20)      ,/* 來源單號 */
isag003       number(10,0)      ,/* 來源項次 */
isag004       number(20,6)      ,/* 發票數量 */
isag005       varchar2(10)      ,/* 發票單位 */
isag006       varchar2(10)      ,/* 稅別 */
isag007       varchar2(1)      ,/* 含稅否 */
isag008       number(5,2)      ,/* 稅率 */
isag009       varchar2(40)      ,/* 料號 */
isag010       varchar2(255)      ,/* 品名 */
isag011       number(5,0)      ,/* 期別 */
isag012       varchar2(10)      ,/* 收款條件 */
isag013       varchar2(20)      ,/* 原始發票編號 */
isag014       varchar2(20)      ,/* 原始發票號碼 */
isag015       number(5,0)      ,/* 正負值 */
isag016       varchar2(40)      ,/* 客戶料號 */
isag017       varchar2(255)      ,/* 客戶品名 */
isag101       number(20,6)      ,/* 原幣單價 */
isag103       number(20,6)      ,/* 原幣未稅金額 */
isag104       number(20,6)      ,/* 原幣稅額 */
isag105       number(20,6)      ,/* 原幣稅後金額 */
isag106       number(20,6)      ,/* 訂金發票已被攤未稅額 */
isag113       number(20,6)      ,/* 本幣未稅金額 */
isag114       number(20,6)      ,/* 本幣稅額 */
isag115       number(20,6)      ,/* 本幣稅後金額 */
isag116       number(20,6)      ,/* 原幣已收金額 */
isag117       number(20,6)      ,/* 本幣已收金額 */
isag126       number(20,6)      ,/* 輔助帳二原幣已收金額　 */
isag127       number(20,6)      ,/* 輔助帳二本幣已收金額　 */
isag128       varchar2(20)      ,/* 輔助帳二應收單號 */
isag136       number(20,6)      ,/* 輔助帳三原幣已收金額　 */
isag137       number(20,6)      ,/* 輔助帳二本幣已收金額　 */
isag138       varchar2(20)      ,/* 輔助帳三應收單號 */
isagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isagud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
isag018       varchar2(1)      /* 訂金已開發票 */
);
alter table isag_t add constraint isag_pk primary key (isagent,isagcomp,isagdocno,isagseq) enable validate;

create  index isag_n1 on isag_t (isagent,isagcomp,isag001,isag002,isag003);
create unique index isag_pk on isag_t (isagent,isagcomp,isagdocno,isagseq);

grant select on isag_t to tiptop;
grant update on isag_t to tiptop;
grant delete on isag_t to tiptop;
grant insert on isag_t to tiptop;

exit;
