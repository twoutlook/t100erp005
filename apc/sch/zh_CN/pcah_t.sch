/* 
================================================================================
檔案代號:pcah_t
檔案名稱:POS角色功能資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcah_t
(
pcahent       number(5)      ,/* 企業編號 */
pcahunit       varchar2(10)      ,/* 應用組織 */
pcah001       varchar2(10)      ,/* 角色編號 */
pcah002       varchar2(40)      ,/* 模塊編號 */
pcah003       varchar2(40)      ,/* 功能編號 */
pcah004       varchar2(10)      ,/* 類型 */
pcahstus       varchar2(10)      ,/* 狀態碼 */
pcahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcah_t add constraint pcah_pk primary key (pcahent,pcah001,pcah002,pcah003) enable validate;

create unique index pcah_pk on pcah_t (pcahent,pcah001,pcah002,pcah003);

grant select on pcah_t to tiptop;
grant update on pcah_t to tiptop;
grant delete on pcah_t to tiptop;
grant insert on pcah_t to tiptop;

exit;
