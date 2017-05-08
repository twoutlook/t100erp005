/* 
================================================================================
檔案代號:xrad_t
檔案名稱:帳齡類型設定主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xrad_t
(
xradent       number(5)      ,/* 企業編號 */
xradownid       varchar2(20)      ,/* 資料所有者 */
xradowndp       varchar2(10)      ,/* 資料所屬部門 */
xradcrtid       varchar2(20)      ,/* 資料建立者 */
xradcrtdp       varchar2(10)      ,/* 資料建立部門 */
xradcrtdt       timestamp(0)      ,/* 資料創建日 */
xradmodid       varchar2(20)      ,/* 資料修改者 */
xradmoddt       timestamp(0)      ,/* 最近修改日 */
xradstus       varchar2(10)      ,/* 狀態碼 */
xrad001       varchar2(10)      ,/* 帳齡類型編號 */
xrad002       varchar2(1)      ,/* no use */
xrad003       varchar2(1)      ,/* no use */
xrad004       varchar2(10)      ,/* 帳齡起算日基準 */
xradud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xradud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xradud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xradud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xradud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xradud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xradud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xradud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xradud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xradud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xradud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xradud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xradud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xradud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xradud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xradud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xradud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xradud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xradud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xradud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xradud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xradud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xradud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xradud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xradud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xradud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xradud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xradud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xradud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xradud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrad_t add constraint xrad_pk primary key (xradent,xrad001) enable validate;

create unique index xrad_pk on xrad_t (xradent,xrad001);

grant select on xrad_t to tiptop;
grant update on xrad_t to tiptop;
grant delete on xrad_t to tiptop;
grant insert on xrad_t to tiptop;

exit;
