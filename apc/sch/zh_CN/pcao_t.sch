/* 
================================================================================
檔案代號:pcao_t
檔案名稱:收銀機可使用庫位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table pcao_t
(
pcaoent       number(5)      ,/* 企業編號 */
pcaosite       varchar2(10)      ,/* 營運據點 */
pcaounit       varchar2(10)      ,/* 應用組織 */
pcao001       varchar2(10)      ,/* 收銀機編號 */
pcao002       varchar2(80)      ,/* 庫位編號 */
pcaostus       varchar2(10)      ,/* 狀態碼 */
pcaostamp       timestamp(5)      ,/* 時間戳記 */
pcaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcaoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcao_t add constraint pcao_pk primary key (pcaoent,pcaosite,pcao001,pcao002) enable validate;

create unique index pcao_pk on pcao_t (pcaoent,pcaosite,pcao001,pcao002);

grant select on pcao_t to tiptop;
grant update on pcao_t to tiptop;
grant delete on pcao_t to tiptop;
grant insert on pcao_t to tiptop;

exit;
