/* 
================================================================================
檔案代號:xrcd_t
檔案名稱:交易稅明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrcd_t
(
xrcdent       number(5)      ,/* 企業編號 */
xrcdcomp       varchar2(10)      ,/* 法人 */
xrcdld       varchar2(5)      ,/* 帳別 */
xrcdsite       varchar2(10)      ,/* 營運據點 */
xrcddocno       varchar2(20)      ,/* 交易單據編號 */
xrcdseq       number(10,0)      ,/* 項次 */
xrcdseq2       number(10,0)      ,/* 項次2 */
xrcdorga       varchar2(10)      ,/* 帳務來源SITE */
xrcd001       varchar2(10)      ,/* 來源作業別 */
xrcd002       varchar2(10)      ,/* 稅別 */
xrcd003       number(5,2)      ,/* 稅率 */
xrcd004       number(20,6)      ,/* 固定課稅金額 */
xrcd005       number(20,6)      ,/* 課稅數量 */
xrcd006       varchar2(1)      ,/* 含稅否 */
xrcd007       number(10,0)      ,/* 計算序 */
xrcd008       varchar2(10)      ,/* no use */
xrcd009       varchar2(24)      ,/* 稅額會計科目 */
xrcd010       date      ,/* no use */
xrcd100       varchar2(10)      ,/* 幣別 */
xrcd101       number(20,10)      ,/* 匯率 */
xrcd102       number(20,6)      ,/* 原幣計算基準 */
xrcd103       number(20,6)      ,/* 原幣未稅金額 */
xrcd104       number(20,6)      ,/* 原幣稅額 */
xrcd105       number(20,6)      ,/* 原幣含稅金額 */
xrcd106       number(20,6)      ,/* 原幣留抵稅額 */
xrcd112       number(20,6)      ,/* 本幣計算基準 */
xrcd113       number(20,6)      ,/* 本幣未稅金額 */
xrcd114       number(20,6)      ,/* 本幣稅額 */
xrcd115       number(20,6)      ,/* 本幣含稅金額 */
xrcd116       number(20,6)      ,/* 本幣留抵稅額 */
xrcd117       number(20,6)      ,/* 已開發票原幣未稅金額 */
xrcd118       number(20,6)      ,/* 已開發票原幣稅額 */
xrcd121       number(20,10)      ,/* 本位幣二匯率 */
xrcd124       number(20,6)      ,/* 本位幣二稅額 */
xrcd131       number(20,10)      ,/* 本位幣三匯率 */
xrcd134       number(20,6)      ,/* 本位幣三稅額 */
xrcd123       number(20,6)      ,/* 本位幣二未稅金額 */
xrcd125       number(20,6)      ,/* 本位幣二含稅金額 */
xrcd133       number(20,6)      ,/* 本位幣三未稅金額 */
xrcd135       number(20,6)      ,/* 本位幣三含稅金額 */
xrcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrcdud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xrcd011       varchar2(20)      ,/* 發票代碼 */
xrcd012       varchar2(20)      ,/* 發票號碼 */
xrcd013       number(10,0)      /* 稅別項次 */
);
alter table xrcd_t add constraint xrcd_pk primary key (xrcdent,xrcdld,xrcddocno,xrcdseq,xrcdseq2,xrcd007) enable validate;

create unique index xrcd_pk on xrcd_t (xrcdent,xrcdld,xrcddocno,xrcdseq,xrcdseq2,xrcd007);

grant select on xrcd_t to tiptop;
grant update on xrcd_t to tiptop;
grant delete on xrcd_t to tiptop;
grant insert on xrcd_t to tiptop;

exit;
