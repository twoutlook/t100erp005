/* 
================================================================================
檔案代號:pcaq_t
檔案名稱:Service差異調整單身表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pcaq_t
(
pcaqent       number(5)      ,/* 企業編號 */
pcaqsite       varchar2(10)      ,/* 營運組織 */
pcaqunit       varchar2(10)      ,/* 應用組織 */
pcaqdocno       varchar2(20)      ,/* 單據編號 */
pcaqseq       number(10,0)      ,/* 項次 */
pcaq001       varchar2(40)      ,/* 請求ID */
pcaq002       varchar2(10)      ,/* 單據類型 */
pcaq003       varchar2(40)      ,/* 服務名 */
pcaq004       date      ,/* 請求日期 */
pcaq005       varchar2(8)      ,/* 請求時間 */
pcaq006       varchar2(10)      ,/* 請求類型 */
pcaq007       varchar2(20)      ,/* 請求單號 */
pcaq008       varchar2(30)      ,/* 使用者名,卡號,券號 */
pcaq009       varchar2(40)      ,/* 更新前資料 */
pcaq010       varchar2(40)      ,/* 更新後資料 */
pcaq011       number(20,6)      ,/* 本次異動 */
pcaq012       varchar2(10)      ,/* 收銀機號 */
pcaq013       number(20,6)      ,/* 本次消費金額 */
pcaq014       varchar2(10)      ,/* 狀態 */
pcaq015       varchar2(40)      ,/* 處理ID */
pcaqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcaqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcaqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcaqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcaqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcaqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcaqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcaqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcaqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcaqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcaqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcaqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcaqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcaqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcaqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcaqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcaqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcaqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcaqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcaqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcaqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcaqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcaqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcaqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcaqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcaqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcaqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcaqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcaqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcaqud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pcaq016       varchar2(10)      /* 異動類型 */
);
alter table pcaq_t add constraint pcaq_pk primary key (pcaqent,pcaqdocno,pcaqseq) enable validate;

create unique index pcaq_pk on pcaq_t (pcaqent,pcaqdocno,pcaqseq);

grant select on pcaq_t to tiptop;
grant update on pcaq_t to tiptop;
grant delete on pcaq_t to tiptop;
grant insert on pcaq_t to tiptop;

exit;
