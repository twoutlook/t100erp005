/* 
================================================================================
檔案代號:ooez_t
檔案名稱:作業組織應用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooez_t
(
ooezent       number(5)      ,/* 企業編號 */
ooez001       varchar2(20)      ,/* 作業編號 */
ooez002       varchar2(10)      ,/* 欄位類型 */
ooez003       varchar2(15)      ,/* 表格代號 */
ooez004       varchar2(20)      ,/* 欄位代號 */
ooez005       varchar2(10)      ,/* 設定類型 */
ooez006       varchar2(10)      ,/* 對應設定值 */
ooez007       varchar2(10)      ,/* 組織結構下展 */
ooezacti       varchar2(10)      ,/* 有效 */
ooezownid       varchar2(20)      ,/* 資料所有者 */
ooezowndp       varchar2(10)      ,/* 資料所屬部門 */
ooezcrtid       varchar2(20)      ,/* 資料建立者 */
ooezcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooezcrtdt       timestamp(0)      ,/* 資料創建日 */
ooezmodid       varchar2(20)      ,/* 資料修改者 */
ooezmoddt       timestamp(0)      ,/* 最近修改日 */
ooez008       varchar2(1)      ,/* 組織控管 */
ooezud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooezud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooezud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooezud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooezud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooezud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooezud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooezud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooezud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooezud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooezud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooezud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooezud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooezud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooezud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooezud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooezud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooezud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooezud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooezud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooezud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooezud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooezud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooezud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooezud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooezud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooezud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooezud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooezud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooezud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooez_t add constraint ooez_pk primary key (ooezent,ooez001,ooez002,ooez004) enable validate;

create unique index ooez_pk on ooez_t (ooezent,ooez001,ooez002,ooez004);

grant select on ooez_t to tiptop;
grant update on ooez_t to tiptop;
grant delete on ooez_t to tiptop;
grant insert on ooez_t to tiptop;

exit;
