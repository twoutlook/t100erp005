/* 
================================================================================
檔案代號:gzxw_t
檔案名稱:使用者在不同營運據點對應角色檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxw_t
(
gzxwstus       varchar2(10)      ,/* 狀態碼 */
gzxwent       number(5)      ,/* 企業編號 */
gzxw001       varchar2(20)      ,/* 員工編號 */
gzxw002       varchar2(10)      ,/* 角色編號 */
gzxw003       varchar2(10)      ,/* 生效營運據點 */
gzxw004       date      ,/* 生效日期 */
gzxw005       date      ,/* 失效日期 */
gzxwownid       varchar2(20)      ,/* 資料所有者 */
gzxwowndp       varchar2(10)      ,/* 資料所屬部門 */
gzxwcrtid       varchar2(20)      ,/* 資料建立者 */
gzxwcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzxwcrtdt       timestamp(0)      ,/* 資料創建日 */
gzxwmodid       varchar2(20)      ,/* 資料修改者 */
gzxwmoddt       timestamp(0)      ,/* 最近修改日 */
gzxwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxw_t add constraint gzxw_pk primary key (gzxwent,gzxw001,gzxw002,gzxw003) enable validate;

create unique index gzxw_pk on gzxw_t (gzxwent,gzxw001,gzxw002,gzxw003);

grant select on gzxw_t to tiptop;
grant update on gzxw_t to tiptop;
grant delete on gzxw_t to tiptop;
grant insert on gzxw_t to tiptop;

exit;
