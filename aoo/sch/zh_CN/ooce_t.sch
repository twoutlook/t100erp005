/* 
================================================================================
檔案代號:ooce_t
檔案名稱:洲別檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooce_t
(
ooceent       number(5)      ,/* 企業編號 */
ooce001       varchar2(10)      ,/* 洲別編號 */
ooceownid       varchar2(20)      ,/* 資料所有者 */
ooceowndp       varchar2(10)      ,/* 資料所屬部門 */
oocecrtid       varchar2(20)      ,/* 資料建立者 */
oocecrtdp       varchar2(10)      ,/* 資料建立部門 */
oocecrtdt       timestamp(0)      ,/* 資料創建日 */
oocemodid       varchar2(20)      ,/* 資料修改者 */
oocemoddt       timestamp(0)      ,/* 最近修改日 */
oocestus       varchar2(10)      ,/* 狀態碼 */
ooceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooce_t add constraint ooce_pk primary key (ooceent,ooce001) enable validate;

create unique index ooce_pk on ooce_t (ooceent,ooce001);

grant select on ooce_t to tiptop;
grant update on ooce_t to tiptop;
grant delete on ooce_t to tiptop;
grant insert on ooce_t to tiptop;

exit;
