/* 
================================================================================
檔案代號:inbj_t
檔案名稱:庫存報廢明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inbj_t
(
inbjent       number(5)      ,/* 企業編號 */
inbjsite       varchar2(10)      ,/* 營運據點 */
inbjdocno       varchar2(20)      ,/* 單據編號 */
inbjseq       number(10,0)      ,/* 項次 */
inbj001       varchar2(40)      ,/* 料件編號 */
inbj002       varchar2(256)      ,/* 產品特徵 */
inbj003       varchar2(30)      ,/* 庫存管理特徵 */
inbj004       varchar2(40)      ,/* 包裝容器編號 */
inbj005       varchar2(10)      ,/* 撥出庫位 */
inbj006       varchar2(10)      ,/* 撥出儲位 */
inbj007       varchar2(30)      ,/* 批號 */
inbj008       varchar2(10)      ,/* 庫存單位 */
inbj009       number(20,6)      ,/* 申請數量 */
inbj010       number(20,6)      ,/* 實際異動數量 */
inbj011       varchar2(10)      ,/* 參考單位 */
inbj012       number(20,6)      ,/* 參考單位申請數量 */
inbj013       number(20,6)      ,/* 參考單位實際數量 */
inbj014       varchar2(10)      ,/* 撥入廢庫位 */
inbj015       varchar2(10)      ,/* 撥入廢儲位 */
inbj016       varchar2(10)      ,/* 報廢原因 */
inbj017       varchar2(10)      ,/* 歸屬部門 */
inbj018       varchar2(20)      ,/* 歸屬單號 */
inbj031       varchar2(255)      ,/* 備註 */
inbjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inbj019       varchar2(20)      ,/* 專案編號 */
inbj020       varchar2(30)      ,/* WBS */
inbj021       varchar2(30)      /* 活動編號 */
);
alter table inbj_t add constraint inbj_pk primary key (inbjent,inbjdocno,inbjseq) enable validate;

create unique index inbj_pk on inbj_t (inbjent,inbjdocno,inbjseq);

grant select on inbj_t to tiptop;
grant update on inbj_t to tiptop;
grant delete on inbj_t to tiptop;
grant insert on inbj_t to tiptop;

exit;
