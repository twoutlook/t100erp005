/* 
================================================================================
檔案代號:gzxc_t
檔案名稱:使用者對角色下可拜訪據點檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxc_t
(
gzxcstus       varchar2(10)      ,/* 狀態碼 */
gzxcent       number(5)      ,/* 企業編號 */
gzxc001       varchar2(20)      ,/* 員工編號 */
gzxc002       varchar2(1)      ,/* 類別 */
gzxc003       varchar2(20)      ,/* 角色或作業編號 */
gzxc004       varchar2(10)      ,/* 據點編號 */
gzxc005       date      ,/* 生效日期 */
gzxcownid       varchar2(20)      ,/* 資料所有者 */
gzxcowndp       varchar2(10)      ,/* 資料所屬部門 */
gzxccrtid       varchar2(20)      ,/* 資料建立者 */
gzxccrtdp       varchar2(10)      ,/* 資料建立部門 */
gzxccrtdt       timestamp(0)      ,/* 資料創建日 */
gzxcmodid       varchar2(20)      ,/* 資料修改者 */
gzxcmoddt       timestamp(0)      ,/* 最近修改日 */
gzxc006       date      ,/* 失效日期 */
gzxc007       varchar2(1)      ,/* 允許下展 */
gzxcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxc_t add constraint gzxc_pk primary key (gzxcent,gzxc001,gzxc002,gzxc003,gzxc004) enable validate;

create unique index gzxc_pk on gzxc_t (gzxcent,gzxc001,gzxc002,gzxc003,gzxc004);

grant select on gzxc_t to tiptop;
grant update on gzxc_t to tiptop;
grant delete on gzxc_t to tiptop;
grant insert on gzxc_t to tiptop;

exit;
