/* 
================================================================================
檔案代號:nmbx_t
檔案名稱:企業帳戶月結統計資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table nmbx_t
(
nmbxent       number(5)      ,/* 企業編碼 */
nmbxcomp       varchar2(10)      ,/* 法人 */
nmbx001       number(5,0)      ,/* 年度 */
nmbx002       number(5,0)      ,/* 月份 */
nmbx003       varchar2(10)      ,/* 交易帳戶編碼 */
nmbx100       varchar2(10)      ,/* 交易帳戶幣別 */
nmbx103       number(20,6)      ,/* 原幣存入金額 */
nmbx104       number(20,6)      ,/* 原幣提出金額 */
nmbx113       number(20,6)      ,/* 本幣存入金額 */
nmbx114       number(20,6)      ,/* 本幣提出金額 */
nmbx123       number(20,6)      ,/* 本位幣二存入金額 */
nmbx124       number(20,6)      ,/* 本位幣二提出金額 */
nmbx133       number(20,6)      ,/* 本位幣三存入金額 */
nmbx134       number(20,6)      ,/* 本位幣三提出金額 */
nmbxownid       varchar2(20)      ,/* 資料所有者 */
nmbxowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbxcrtid       varchar2(20)      ,/* 資料建立者 */
nmbxcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbxcrtdt       timestamp(0)      ,/* 資料創建日 */
nmbxmodid       varchar2(20)      ,/* 資料修改者 */
nmbxmoddt       timestamp(0)      ,/* 最近修改日 */
nmbxcnfid       varchar2(20)      ,/* 資料確認者 */
nmbxcnfdt       timestamp(0)      ,/* 資料確認日 */
nmbxpstid       varchar2(20)      ,/* 資料過帳者 */
nmbxpstdt       timestamp(0)      ,/* 資料過帳日 */
nmbxstus       varchar2(10)      ,/* 狀態碼 */
nmbxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbxud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmbxorga       varchar2(10)      /* 來源組織 */
);
alter table nmbx_t add constraint nmbx_pk primary key (nmbxent,nmbxcomp,nmbx001,nmbx002,nmbx003,nmbxorga) enable validate;

create unique index nmbx_pk on nmbx_t (nmbxent,nmbxcomp,nmbx001,nmbx002,nmbx003,nmbxorga);

grant select on nmbx_t to tiptop;
grant update on nmbx_t to tiptop;
grant delete on nmbx_t to tiptop;
grant insert on nmbx_t to tiptop;

exit;
