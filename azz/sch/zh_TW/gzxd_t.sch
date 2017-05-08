/* 
================================================================================
檔案代號:gzxd_t
檔案名稱:使用者密碼設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxd_t
(
gzxdent       number(5)      ,/* 企業編號 */
gzxd001       varchar2(20)      ,/* 使用者編號 */
gzxd002       varchar2(80)      ,/* 用戶密碼 (編碼) */
gzxd003       date      ,/* 修改狀態紀錄 */
gzxd004       varchar2(1)      ,/* 下次登入是否需要修改密碼 */
gzxdstus       varchar2(10)      ,/* 狀態碼 */
gzxdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxd_t add constraint gzxd_pk primary key (gzxdent,gzxd001) enable validate;

create unique index gzxd_pk on gzxd_t (gzxdent,gzxd001);

grant select on gzxd_t to tiptop;
grant update on gzxd_t to tiptop;
grant delete on gzxd_t to tiptop;
grant insert on gzxd_t to tiptop;

exit;
