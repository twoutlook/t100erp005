/* 
================================================================================
檔案代號:glee_t
檔案名稱:合併現金流量表上下層公司現金變動碼對應資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glee_t
(
gleeent       number(5)      ,/* 企業編號 */
glee001       varchar2(5)      ,/* 帳別/合併帳別(轉換前 */
glee002       varchar2(10)      ,/* 公司編號(轉換前) */
glee003       varchar2(5)      ,/* 合併帳別(轉換後) */
glee004       varchar2(10)      ,/* 公司編號(轉換後) */
glee005       varchar2(10)      ,/* 現金變動碼(轉換前) */
glee006       varchar2(10)      ,/* 現金變動碼(轉換後) */
glee007       varchar2(1)      ,/* 記帳幣換算類別 */
glee008       varchar2(1)      ,/* 功能幣換算類別 */
glee009       varchar2(1)      ,/* 報告幣換算類別 */
gleeownid       varchar2(20)      ,/* 資料所有者 */
gleeowndp       varchar2(10)      ,/* 資料所屬部門 */
gleecrtid       varchar2(20)      ,/* 資料建立者 */
gleecrtdp       varchar2(10)      ,/* 資料建立部門 */
gleecrtdt       timestamp(0)      ,/* 資料創建日 */
gleemodid       varchar2(20)      ,/* 資料修改者 */
gleemoddt       timestamp(0)      ,/* 最近修改日 */
gleestus       varchar2(10)      ,/* 狀態碼 */
gleeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gleeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gleeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gleeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gleeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gleeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gleeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gleeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gleeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gleeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gleeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gleeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gleeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gleeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gleeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gleeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gleeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gleeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gleeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gleeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gleeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gleeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gleeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gleeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gleeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gleeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gleeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gleeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gleeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gleeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glee_t add constraint glee_pk primary key (gleeent,glee001,glee002,glee003,glee004,glee005) enable validate;

create unique index glee_pk on glee_t (gleeent,glee001,glee002,glee003,glee004,glee005);

grant select on glee_t to tiptop;
grant update on glee_t to tiptop;
grant delete on glee_t to tiptop;
grant insert on glee_t to tiptop;

exit;
