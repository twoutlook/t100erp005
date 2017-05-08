/* 
================================================================================
檔案代號:fmmg_t
檔案名稱:投資審核單檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmg_t
(
fmmgent       number(5)      ,/* 企業代碼 */
fmmgownid       varchar2(20)      ,/* 資料所有者 */
fmmgowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmgcrtid       varchar2(20)      ,/* 資料建立者 */
fmmgcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmgcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmgmodid       varchar2(20)      ,/* 資料修改者 */
fmmgmoddt       timestamp(0)      ,/* 最近修改日 */
fmmgcnfid       varchar2(20)      ,/* 資料確認者 */
fmmgcnfdt       timestamp(0)      ,/* 資料確認日 */
fmmgpstid       varchar2(20)      ,/* 資料過帳者 */
fmmgpstdt       timestamp(0)      ,/* 資料過帳日 */
fmmgstus       varchar2(10)      ,/* 狀態碼 */
fmmgdocno       varchar2(20)      ,/* 投資審核單號 */
fmmgdocdt       date      ,/* 日期 */
fmmg001       date      ,/* 平倉期限 */
fmmg002       varchar2(10)      ,/* 投資組織 */
fmmg003       varchar2(10)      ,/* 投資類型 */
fmmg004       varchar2(10)      ,/* 交易市場 */
fmmg005       varchar2(20)      ,/* 投資標的 */
fmmg006       varchar2(10)      ,/* 預算項目 */
fmmg007       number(20,6)      ,/* 預算金額 */
fmmg008       varchar2(10)      ,/* 幣別 */
fmmg009       number(20,6)      ,/* 總額度 */
fmmgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmmg_t add constraint fmmg_pk primary key (fmmgent,fmmgdocno) enable validate;

create unique index fmmg_pk on fmmg_t (fmmgent,fmmgdocno);

grant select on fmmg_t to tiptop;
grant update on fmmg_t to tiptop;
grant delete on fmmg_t to tiptop;
grant insert on fmmg_t to tiptop;

exit;
