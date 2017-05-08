/* 
================================================================================
檔案代號:xcfd_t
檔案名稱:LCM計算基礎輔檔-除外倉庫維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcfd_t
(
xcfdent       number(5)      ,/* 企業編號 */
xcfdcomp       varchar2(10)      ,/* 法人組織 */
xcfdld       varchar2(5)      ,/* 帳套 */
xcfd001       number(5,0)      ,/* 年度 */
xcfd002       number(5,0)      ,/* 期別 */
xcfdseq       number(10,0)      ,/* 項次 */
xcfd010       varchar2(10)      ,/* 倉庫別 */
xcfdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcfdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcfdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcfdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcfdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcfdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcfdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcfdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcfdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcfdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcfdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcfdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcfdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcfdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcfdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcfdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcfdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcfdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcfdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcfdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcfdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcfdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcfdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcfdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcfdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcfdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcfdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcfdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcfdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcfdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcfd_t add constraint xcfd_pk primary key (xcfdent,xcfdld,xcfd001,xcfd002,xcfdseq) enable validate;

create unique index xcfd_pk on xcfd_t (xcfdent,xcfdld,xcfd001,xcfd002,xcfdseq);

grant select on xcfd_t to tiptop;
grant update on xcfd_t to tiptop;
grant delete on xcfd_t to tiptop;
grant insert on xcfd_t to tiptop;

exit;
