/* 
================================================================================
檔案代號:staw_t
檔案名稱:供應商合約申請結算帳期資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table staw_t
(
stawent       number(5)      ,/* 企業編號 */
stawsite       varchar2(10)      ,/* 營運據點 */
stawunit       varchar2(10)      ,/* 應用組織 */
stawdocno       varchar2(20)      ,/* 單據編號 */
stawseq       number(10,0)      ,/* 帳期 */
staw001       varchar2(20)      ,/* 合約編號 */
staw002       date      ,/* 起止日期 */
staw003       date      ,/* 截止日期 */
staw004       date      ,/* 結算日期 */
staw005       varchar2(1)      ,/* 結算否 */
staw006       varchar2(20)      ,/* 結算單號 */
stawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stawud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
staw007       varchar2(10)      /* 法人 */
);
alter table staw_t add constraint staw_pk primary key (stawent,stawdocno,stawseq,staw007) enable validate;

create unique index staw_pk on staw_t (stawent,stawdocno,stawseq,staw007);

grant select on staw_t to tiptop;
grant update on staw_t to tiptop;
grant delete on staw_t to tiptop;
grant insert on staw_t to tiptop;

exit;
