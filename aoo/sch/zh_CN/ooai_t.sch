/* 
================================================================================
檔案代號:ooai_t
檔案名稱:幣別檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooai_t
(
ooaient       number(5)      ,/* 企業編號 */
ooaistus       varchar2(10)      ,/* 狀態碼 */
ooai001       varchar2(10)      ,/* 幣別編號 */
ooai002       varchar2(10)      ,/* 國家地區 */
ooai003       varchar2(10)      ,/* 最小面額 */
ooai004       varchar2(10)      ,/* 貨幣符號 */
ooai005       varchar2(10)      ,/* ISO代碼 */
ooaiownid       varchar2(20)      ,/* 資料所有者 */
ooaiowndp       varchar2(10)      ,/* 資料所屬部門 */
ooaicrtid       varchar2(20)      ,/* 資料建立者 */
ooaicrtdp       varchar2(10)      ,/* 資料建立部門 */
ooaicrtdt       timestamp(0)      ,/* 資料創建日 */
ooaimodid       varchar2(20)      ,/* 資料修改者 */
ooaimoddt       timestamp(0)      ,/* 最近修改日 */
ooaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooai_t add constraint ooai_pk primary key (ooaient,ooai001) enable validate;

create unique index ooai_pk on ooai_t (ooaient,ooai001);

grant select on ooai_t to tiptop;
grant update on ooai_t to tiptop;
grant delete on ooai_t to tiptop;
grant insert on ooai_t to tiptop;

exit;
