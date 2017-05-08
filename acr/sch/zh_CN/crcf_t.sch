/* 
================================================================================
檔案代號:crcf_t
檔案名稱:客戶回訪記錄問卷明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table crcf_t
(
crcfent       number(5)      ,/* 企業編號 */
crcfsite       varchar2(10)      ,/* 營運據點 */
crcfunit       varchar2(10)      ,/* 應用組織 */
crcfdocno       varchar2(20)      ,/* 回訪單號 */
crcf001       varchar2(10)      ,/* 問題編號 */
crcf002       number(15,3)      ,/* 本次得分 */
crcf003       varchar2(4000)      ,/* 說明 */
crcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crcf_t add constraint crcf_pk primary key (crcfent,crcfdocno,crcf001) enable validate;

create unique index crcf_pk on crcf_t (crcfent,crcfdocno,crcf001);

grant select on crcf_t to tiptop;
grant update on crcf_t to tiptop;
grant delete on crcf_t to tiptop;
grant insert on crcf_t to tiptop;

exit;
