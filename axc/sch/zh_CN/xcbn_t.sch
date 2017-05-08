/* 
================================================================================
檔案代號:xcbn_t
檔案名稱:轉撥計價檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcbn_t
(
xcbnent       number(5)      ,/* 企業編號 */
xcbn001       number(5,0)      ,/* 年度 */
xcbn002       number(5,0)      ,/* 期別 */
xcbn003       varchar2(10)      ,/* 撥出營運據點 */
xcbn004       varchar2(10)      ,/* 撥入營運據點 */
xcbn005       varchar2(40)      ,/* 料號 */
xcbn006       varchar2(256)      ,/* 特性 */
xcbn010       varchar2(10)      ,/* 計價幣別 */
xcbn102       number(20,6)      ,/* 轉撥單價 */
xcbn102a       number(20,6)      ,/* 材料單價 */
xcbn102b       number(20,6)      ,/* 人工單價 */
xcbn102c       number(20,6)      ,/* 委外加工單價 */
xcbn102d       number(20,6)      ,/* 制費一單價 */
xcbn102e       number(20,6)      ,/* 制費二單價 */
xcbn102f       number(20,6)      ,/* 制費三單價 */
xcbn102g       number(20,6)      ,/* 制費四單價 */
xcbn102h       number(20,6)      ,/* 制費五單價 */
xcbnownid       varchar2(20)      ,/* 資料所有者 */
xcbnowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbncrtid       varchar2(20)      ,/* 資料建立者 */
xcbncrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbncrtdt       timestamp(0)      ,/* 資料創建日 */
xcbnmodid       varchar2(20)      ,/* 資料修改者 */
xcbnmoddt       timestamp(0)      ,/* 最近修改日 */
xcbnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbn_t add constraint xcbn_pk primary key (xcbnent,xcbn001,xcbn002,xcbn003,xcbn004,xcbn005,xcbn006) enable validate;

create unique index xcbn_pk on xcbn_t (xcbnent,xcbn001,xcbn002,xcbn003,xcbn004,xcbn005,xcbn006);

grant select on xcbn_t to tiptop;
grant update on xcbn_t to tiptop;
grant delete on xcbn_t to tiptop;
grant insert on xcbn_t to tiptop;

exit;
