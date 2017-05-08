/* 
================================================================================
檔案代號:xrcc_t
檔案名稱:多帳期明細
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrcc_t
(
xrccent       number(5)      ,/* 企業編號 */
xrccld       varchar2(5)      ,/* 帳別 */
xrcccomp       varchar2(10)      ,/* 法人 */
xrccdocno       varchar2(20)      ,/* 應收帳款單號碼 */
xrccseq       number(10,0)      ,/* 項次 */
xrcc001       number(10,0)      ,/* 期別 */
xrcc002       varchar2(10)      ,/* 應收收款類別 */
xrcc003       date      ,/* 應收款日 */
xrcc004       date      ,/* 容許票據到期日 */
xrcc005       date      ,/* 帳款起算日 */
xrcc006       number(5,0)      ,/* 正負值 */
xrcclegl       varchar2(10)      ,/* 核算組織 */
xrcc008       varchar2(20)      ,/* 發票代碼 */
xrcc009       varchar2(20)      ,/* 發票號碼 */
xrccsite       varchar2(10)      ,/* 帳務中心 */
xrcc010       date      ,/* 發票日期 */
xrcc011       date      ,/* 出貨單據日期 */
xrcc012       date      ,/* 立帳日期 */
xrcc013       date      ,/* 交易認定日期 */
xrcc014       date      ,/* 出入庫扣帳日期 */
xrcc100       varchar2(10)      ,/* 交易原幣別 */
xrcc101       number(20,10)      ,/* 原幣匯率 */
xrcc102       number(20,10)      ,/* 原幣重估後匯率 */
xrcc103       number(20,6)      ,/* 重評價調整數 */
xrcc104       number(20,6)      ,/* No Use */
xrcc105       number(20,6)      ,/* No Use */
xrcc106       number(20,6)      ,/* No Use */
xrcc107       number(20,6)      ,/* No Use */
xrcc108       number(20,6)      ,/* 原幣應收金額 */
xrcc109       number(20,6)      ,/* 原幣收款沖帳金額 */
xrcc113       number(20,6)      ,/* 本幣重評價調整數 */
xrcc114       number(20,6)      ,/* No Use */
xrcc115       number(20,6)      ,/* No Use */
xrcc116       number(20,6)      ,/* No Use */
xrcc117       number(20,6)      ,/* No Use */
xrcc118       number(20,6)      ,/* 本幣應收金額 */
xrcc119       number(20,6)      ,/* 本幣收款沖帳金額 */
xrcc120       varchar2(10)      ,/* 本位幣二幣別 */
xrcc121       number(20,10)      ,/* 本位幣二匯率 */
xrcc122       number(20,10)      ,/* 本位幣二重估後匯率 */
xrcc123       number(20,6)      ,/* 本位幣二重評價調整數 */
xrcc124       number(20,6)      ,/* No Use */
xrcc125       number(20,6)      ,/* No Use */
xrcc126       number(20,6)      ,/* No Use */
xrcc127       number(20,6)      ,/* No Use */
xrcc128       number(20,6)      ,/* 本位幣二應收金額 */
xrcc129       number(20,6)      ,/* 本位幣二收款沖帳金額 */
xrcc130       varchar2(10)      ,/* 本位幣三幣別 */
xrcc131       number(20,10)      ,/* 本位幣三匯率 */
xrcc132       number(20,10)      ,/* 本位幣三重估後匯率 */
xrcc133       number(20,6)      ,/* 本位幣三重評價調整數 */
xrcc134       number(20,6)      ,/* No Use */
xrcc135       number(20,6)      ,/* No Use */
xrcc136       number(20,6)      ,/* No Use */
xrcc137       number(20,6)      ,/* No Use */
xrcc138       number(20,6)      ,/* 本位幣三應收金額 */
xrcc139       number(20,6)      ,/* 本位幣三收款沖帳金額 */
xrccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrccud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xrcc015       varchar2(10)      ,/* 收款條件 */
xrcc016       varchar2(10)      ,/* 帳款類型 */
xrcc017       varchar2(20)      /* 訂單單號 */
);
alter table xrcc_t add constraint xrcc_pk primary key (xrccent,xrccld,xrccdocno,xrccseq,xrcc001) enable validate;

create  index xrcc_01 on xrcc_t (xrcccomp,xrcc002,xrcclegl,xrccsite);
create unique index xrcc_pk on xrcc_t (xrccent,xrccld,xrccdocno,xrccseq,xrcc001);

grant select on xrcc_t to tiptop;
grant update on xrcc_t to tiptop;
grant delete on xrcc_t to tiptop;
grant insert on xrcc_t to tiptop;

exit;
