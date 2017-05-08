/* 
================================================================================
檔案代號:glfh_t
檔案名稱:合併報表幣別轉換設定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glfh_t
(
glfhent       number(5)      ,/* 企業編號 */
glfh001       varchar2(5)      ,/* 合併帳別 */
glfh002       varchar2(10)      ,/* 上層公司編號 */
glfh003       varchar2(1)      ,/* 本位幣順序(上層公司) */
glfh004       varchar2(10)      ,/* 下層公司編號 */
glfh005       varchar2(5)      ,/* 帳別(下層公司) */
glfh006       varchar2(1)      ,/* 本位幣順序(下層公司) */
glfhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glfhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glfhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glfhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glfhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glfhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glfhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glfhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glfhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glfhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glfhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glfhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glfhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glfhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glfhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glfhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glfhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glfhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glfhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glfhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glfhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glfhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glfhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glfhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glfhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glfhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glfhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glfhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glfhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glfhud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glfhownid       varchar2(20)      ,/* 資料所有者 */
glfhowndp       varchar2(10)      ,/* 資料所屬部門 */
glfhcrtid       varchar2(20)      ,/* 資料建立者 */
glfhcrtdp       varchar2(10)      ,/* 資料建立部門 */
glfhcrtdt       timestamp(0)      ,/* 資料創建日 */
glfhmodid       varchar2(20)      ,/* 資料修改者 */
glfhmoddt       timestamp(0)      ,/* 最近修改日 */
glfhstus       varchar2(10)      /* 狀態碼 */
);
alter table glfh_t add constraint glfh_pk primary key (glfhent,glfh001,glfh002,glfh003,glfh004) enable validate;

create unique index glfh_pk on glfh_t (glfhent,glfh001,glfh002,glfh003,glfh004);

grant select on glfh_t to tiptop;
grant update on glfh_t to tiptop;
grant delete on glfh_t to tiptop;
grant insert on glfh_t to tiptop;

exit;
