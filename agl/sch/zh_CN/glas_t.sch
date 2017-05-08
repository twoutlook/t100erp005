/* 
================================================================================
檔案代號:glas_t
檔案名稱:科目核算項設置默認值表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glas_t
(
glasent       number(5)      ,/* 企業代碼 */
glasownid       varchar2(20)      ,/* 資料所有者 */
glasowndp       varchar2(10)      ,/* 資料所屬部門 */
glascrtid       varchar2(20)      ,/* 資料建立者 */
glascrtdp       varchar2(10)      ,/* 資料建立部門 */
glascrtdt       timestamp(0)      ,/* 資料創建日 */
glasmodid       varchar2(20)      ,/* 資料修改者 */
glasmoddt       timestamp(0)      ,/* 最近修改日 */
glasstus       varchar2(10)      ,/* 狀態碼 */
glasld       varchar2(5)      ,/* 帳套 */
glas001       varchar2(24)      ,/* 科目編號 */
glas002       varchar2(10)      ,/* 核算項類型 */
glas003       varchar2(255)      ,/* 默認值 */
glasud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glasud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glasud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glasud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glasud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glasud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glasud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glasud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glasud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glasud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glasud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glasud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glasud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glasud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glasud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glasud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glasud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glasud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glasud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glasud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glasud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glasud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glasud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glasud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glasud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glasud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glasud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glasud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glasud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glasud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glas_t add constraint glas_pk primary key (glasent,glasld,glas001,glas002) enable validate;

create unique index glas_pk on glas_t (glasent,glasld,glas001,glas002);

grant select on glas_t to tiptop;
grant update on glas_t to tiptop;
grant delete on glas_t to tiptop;
grant insert on glas_t to tiptop;

exit;
