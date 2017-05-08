/* 
================================================================================
檔案代號:ooeh_t
檔案名稱:據點級資料集團控制設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooeh_t
(
ooehent       number(5)      ,/* 企業編號 */
ooeh001       varchar2(10)      ,/* 資料類型 */
ooeh002       varchar2(20)      ,/* 欄位代號 */
ooehownid       varchar2(20)      ,/* 資料所有者 */
ooehowndp       varchar2(10)      ,/* 資料所屬部門 */
ooehcrtid       varchar2(20)      ,/* 資料建立者 */
ooehcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooehcrtdt       timestamp(0)      ,/* 資料創建日 */
ooehmodid       varchar2(20)      ,/* 資料修改者 */
ooehmoddt       timestamp(0)      ,/* 最近修改日 */
ooehstus       varchar2(10)      ,/* 狀態碼 */
ooehud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooehud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooehud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooehud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooehud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooehud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooehud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooehud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooehud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooehud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooehud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooehud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooehud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooehud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooehud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooehud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooehud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooehud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooehud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooehud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooehud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooehud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooehud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooehud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooehud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooehud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooehud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooehud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooehud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooehud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooeh_t add constraint ooeh_pk primary key (ooehent,ooeh001,ooeh002) enable validate;

create unique index ooeh_pk on ooeh_t (ooehent,ooeh001,ooeh002);

grant select on ooeh_t to tiptop;
grant update on ooeh_t to tiptop;
grant delete on ooeh_t to tiptop;
grant insert on ooeh_t to tiptop;

exit;
