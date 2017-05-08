/* 
================================================================================
檔案代號:xcjc_t
檔案名稱:銷售收入內部拆分比率設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcjc_t
(
xcjcent       number(5)      ,/* 企業編號 */
xcjc001       varchar2(10)      ,/* 計算類型(版本) */
xcjc002       number(5,0)      ,/* 年度 */
xcjc003       number(5,0)      ,/* 期別 */
xcjc004       varchar2(40)      ,/* 料號 */
xcjc005       varchar2(10)      ,/* 銷售組織 */
xcjc006       varchar2(10)      ,/* 分攤組織 */
xcjc007       number(20,6)      ,/* 分攤比率 */
xcjcownid       varchar2(20)      ,/* 資料所有者 */
xcjcowndp       varchar2(10)      ,/* 資料所屬部門 */
xcjccrtid       varchar2(20)      ,/* 資料建立者 */
xcjccrtdp       varchar2(10)      ,/* 資料建立部門 */
xcjccrtdt       timestamp(0)      ,/* 資料創建日 */
xcjcmodid       varchar2(20)      ,/* 資料修改者 */
xcjcmoddt       timestamp(0)      ,/* 最近修改日 */
xcjcstus       varchar2(10)      ,/* 狀態碼 */
xcjcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcjcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcjcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcjcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcjcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcjcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcjcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcjcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcjcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcjcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcjcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcjcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcjcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcjcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcjcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcjcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcjcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcjcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcjcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcjcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcjcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcjcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcjcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcjcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcjcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcjcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcjcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcjcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcjcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcjcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcjc_t add constraint xcjc_pk primary key (xcjcent,xcjc001,xcjc002,xcjc003,xcjc004,xcjc005,xcjc006) enable validate;

create unique index xcjc_pk on xcjc_t (xcjcent,xcjc001,xcjc002,xcjc003,xcjc004,xcjc005,xcjc006);

grant select on xcjc_t to tiptop;
grant update on xcjc_t to tiptop;
grant delete on xcjc_t to tiptop;
grant insert on xcjc_t to tiptop;

exit;
