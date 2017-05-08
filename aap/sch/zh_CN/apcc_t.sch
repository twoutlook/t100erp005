/* 
================================================================================
檔案代號:apcc_t
檔案名稱:應付多帳期檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apcc_t
(
apccent       number(5)      ,/* 企業編號 */
apccld       varchar2(5)      ,/* 帳別 */
apcccomp       varchar2(10)      ,/* 法人 */
apcclegl       varchar2(10)      ,/* 核算組織 */
apccsite       varchar2(10)      ,/* 帳務中心 */
apccdocno       varchar2(20)      ,/* 應付帳款單號碼 */
apccseq       number(10,0)      ,/* 項次 */
apcc001       number(10,0)      ,/* 分期帳款序 */
apcc002       varchar2(10)      ,/* 應付款別性質 */
apcc003       date      ,/* 應付款日 */
apcc004       date      ,/* 容許票據到期日 */
apcc005       date      ,/* 帳款起算日 */
apcc006       number(5,0)      ,/* 正負值 */
apcc007       number(20,6)      ,/* 原幣已請款金額 */
apcc008       varchar2(20)      ,/* 發票代碼 */
apcc009       varchar2(20)      ,/* 發票號碼 */
apcc010       date      ,/* 發票日期 */
apcc011       date      ,/* 交易單據日期 */
apcc012       date      ,/* 立帳日期 */
apcc013       date      ,/* 交易認定日期 */
apcc014       date      ,/* 出入庫扣帳日期 */
apcc100       varchar2(10)      ,/* 交易原幣別 */
apcc101       number(20,10)      ,/* 原幣匯率 */
apcc102       number(20,10)      ,/* 原幣重估後匯率 */
apcc103       number(20,6)      ,/* NO USE */
apcc104       number(20,6)      ,/* NO USE */
apcc105       number(20,6)      ,/* NO USE */
apcc106       number(20,6)      ,/* NO USE */
apcc107       number(20,6)      ,/* NO USE */
apcc108       number(20,6)      ,/* 原幣應付金額 */
apcc109       number(20,6)      ,/* 原幣付款沖帳金額 */
apcc113       number(20,6)      ,/* 重評價調整數 */
apcc114       number(20,6)      ,/* NO USE */
apcc115       number(20,6)      ,/* NO USE */
apcc116       number(20,6)      ,/* NO USE */
apcc117       number(20,6)      ,/* NO USE */
apcc118       number(20,6)      ,/* 本幣應付金額 */
apcc119       number(20,6)      ,/* 本幣付款沖帳金額 */
apcc120       varchar2(10)      ,/* 本位幣二幣別 */
apcc121       number(20,10)      ,/* 本位幣二匯率 */
apcc122       number(20,10)      ,/* 本位幣二重估後匯率 */
apcc123       number(20,6)      ,/* 重評價調整數 */
apcc124       number(20,6)      ,/* NO USE */
apcc125       number(20,6)      ,/* NO USE */
apcc126       number(20,6)      ,/* NO USE */
apcc127       number(20,6)      ,/* NO USE */
apcc128       number(20,6)      ,/* 本位幣二應付金額 */
apcc129       number(20,6)      ,/* 本位幣二付款沖帳金額 */
apcc130       varchar2(10)      ,/* 本位幣三幣別 */
apcc131       number(20,10)      ,/* 本位幣三匯率 */
apcc132       number(20,10)      ,/* 本位幣三重估後匯率 */
apcc133       number(20,6)      ,/* 重評價調整數 */
apcc134       number(20,6)      ,/* NO USE */
apcc135       number(20,6)      ,/* NO USE */
apcc136       number(20,6)      ,/* NO USE */
apcc137       number(20,6)      ,/* NO USE */
apcc138       number(20,6)      ,/* 本位幣三應付金額 */
apcc139       number(20,6)      ,/* 本位幣三付款沖帳金額 */
apccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apccud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apcc015       varchar2(10)      ,/* 付款條件 */
apcc016       varchar2(10)      ,/* 帳款類型 */
apcc017       varchar2(20)      /* 採購單號 */
);
alter table apcc_t add constraint apcc_pk primary key (apccent,apccld,apccdocno,apccseq,apcc001,apcc009) enable validate;

create unique index apcc_pk on apcc_t (apccent,apccld,apccdocno,apccseq,apcc001,apcc009);

grant select on apcc_t to tiptop;
grant update on apcc_t to tiptop;
grant delete on apcc_t to tiptop;
grant insert on apcc_t to tiptop;

exit;
