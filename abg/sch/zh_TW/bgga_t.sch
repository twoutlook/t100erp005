/* 
================================================================================
檔案代號:bgga_t
檔案名稱:職級職等檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgga_t
(
bggaent       number(5)      ,/* 企業編號 */
bggaownid       varchar2(20)      ,/* 資料所有者 */
bggaowndp       varchar2(10)      ,/* 資料所屬部門 */
bggacrtid       varchar2(20)      ,/* 資料建立者 */
bggacrtdp       varchar2(10)      ,/* 資料建立部門 */
bggacrtdt       timestamp(0)      ,/* 資料創建日 */
bggamodid       varchar2(20)      ,/* 資料修改者 */
bggamoddt       timestamp(0)      ,/* 最近修改日 */
bggastus       varchar2(10)      ,/* 狀態碼 */
bgga001       varchar2(10)      ,/* 來源作業編號 */
bgga002       varchar2(10)      ,/* 編號 */
bggaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bggaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bggaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bggaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bggaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bggaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bggaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bggaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bggaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bggaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bggaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bggaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bggaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bggaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bggaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bggaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bggaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bggaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bggaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bggaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bggaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bggaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bggaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bggaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bggaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bggaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bggaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bggaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bggaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bggaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgga_t add constraint bgga_pk primary key (bggaent,bgga001,bgga002) enable validate;

create unique index bgga_pk on bgga_t (bggaent,bgga001,bgga002);

grant select on bgga_t to tiptop;
grant update on bgga_t to tiptop;
grant delete on bgga_t to tiptop;
grant insert on bgga_t to tiptop;

exit;
