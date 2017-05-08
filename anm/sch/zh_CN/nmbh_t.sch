/* 
================================================================================
檔案代號:nmbh_t
檔案名稱:資金計劃編製單位權限檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table nmbh_t
(
nmbhent       number(5)      ,/* 企業編號 */
nmbh001       varchar2(1)      ,/* 組織類型 */
nmbh002       varchar2(10)      ,/* 版本 */
nmbh003       varchar2(10)      ,/* 收支項目版本 */
nmbh004       varchar2(10)      ,/* 資金計劃組織代碼 */
nmbh005       varchar2(10)      ,/* 收支項目代碼 */
nmbh006       varchar2(10)      ,/* 編製單位代碼 */
nmbh007       varchar2(10)      ,/* 審批單位代碼 */
nmbh008       varchar2(10)      ,/* 變更單位代碼 */
nmbhownid       varchar2(20)      ,/* 資料所有者 */
nmbhowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbhcrtid       varchar2(20)      ,/* 資料建立者 */
nmbhcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbhcrtdt       timestamp(0)      ,/* 資料創建日 */
nmbhmodid       varchar2(20)      ,/* 資料修改者 */
nmbhmoddt       timestamp(0)      ,/* 最近修改日 */
nmbhstus       varchar2(10)      ,/* 狀態碼 */
nmbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbh_t add constraint nmbh_pk primary key (nmbhent,nmbh001,nmbh002,nmbh003,nmbh004,nmbh005) enable validate;

create unique index nmbh_pk on nmbh_t (nmbhent,nmbh001,nmbh002,nmbh003,nmbh004,nmbh005);

grant select on nmbh_t to tiptop;
grant update on nmbh_t to tiptop;
grant delete on nmbh_t to tiptop;
grant insert on nmbh_t to tiptop;

exit;
