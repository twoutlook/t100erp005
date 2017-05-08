/* 
================================================================================
檔案代號:xcbe_t
檔案名稱:在制約當量設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbe_t
(
xcbeent       number(5)      ,/* 企業編號 */
xcbesite       varchar2(10)      ,/* 營運據點 */
xcbe001       number(5,0)      ,/* 年度 */
xcbe002       number(5,0)      ,/* 期別 */
xcbe003       varchar2(40)      ,/* 製程料號 */
xcbe004       varchar2(256)      ,/* 料號特性 */
xcbe005       varchar2(10)      ,/* 製程編號 */
xcbe006       number(10,0)      ,/* 製程序 */
xcbe007       number(15,3)      ,/* 標準約當值 */
xcbeownid       varchar2(20)      ,/* 資料所有者 */
xcbeowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbecrtid       varchar2(20)      ,/* 資料建立者 */
xcbecrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbecrtdt       timestamp(0)      ,/* 資料創建日 */
xcbemodid       varchar2(20)      ,/* 資料修改者 */
xcbemoddt       timestamp(0)      ,/* 最近修改日 */
xcbestus       varchar2(10)      ,/* 狀態碼 */
xcbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbe_t add constraint xcbe_pk primary key (xcbeent,xcbesite,xcbe001,xcbe002,xcbe003,xcbe004,xcbe005,xcbe006) enable validate;

create unique index xcbe_pk on xcbe_t (xcbeent,xcbesite,xcbe001,xcbe002,xcbe003,xcbe004,xcbe005,xcbe006);

grant select on xcbe_t to tiptop;
grant update on xcbe_t to tiptop;
grant delete on xcbe_t to tiptop;
grant insert on xcbe_t to tiptop;

exit;
