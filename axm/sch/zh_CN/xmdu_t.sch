/* 
================================================================================
檔案代號:xmdu_t
檔案名稱:銷售核價單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdu_t
(
xmduent       number(5)      ,/* 企業編號 */
xmdusite       varchar2(10)      ,/* 營運據點 */
xmdudocno       varchar2(20)      ,/* 單號 */
xmduseq       number(10,0)      ,/* 項次 */
xmdu001       varchar2(1)      ,/* 委外否 */
xmdu002       varchar2(40)      ,/* 料件編號 */
xmdu003       varchar2(256)      ,/* 產品特徵 */
xmdu004       varchar2(40)      ,/* 包裝容器 */
xmdu005       varchar2(40)      ,/* 客戶料號 */
xmdu006       varchar2(10)      ,/* 作業編號 */
xmdu007       varchar2(10)      ,/* 製程序 */
xmdu008       varchar2(10)      ,/* 核價單位 */
xmdu009       varchar2(1)      ,/* 分量計價否 */
xmdu010       number(20,6)      ,/* 上次單價 */
xmdu011       number(20,6)      ,/* 單價 */
xmdu012       number(5,2)      ,/* 稅率 */
xmdu013       number(20,6)      ,/* 折扣率 */
xmdu014       varchar2(10)      ,/* 運輸方式 */
xmdu015       varchar2(10)      ,/* 理由碼 */
xmdu030       varchar2(255)      ,/* 備註 */
xmduud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmduud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmduud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmduud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmduud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmduud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmduud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmduud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmduud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmduud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmduud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmduud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmduud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmduud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmduud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmduud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmduud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmduud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmduud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmduud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmduud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmduud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmduud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmduud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmduud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmduud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmduud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmduud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmduud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmduud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmdu031       varchar2(10)      ,/* 系列 */
xmdu032       varchar2(10)      /* 產品分類 */
);
alter table xmdu_t add constraint xmdu_pk primary key (xmduent,xmdudocno,xmduseq) enable validate;

create unique index xmdu_pk on xmdu_t (xmduent,xmdudocno,xmduseq);

grant select on xmdu_t to tiptop;
grant update on xmdu_t to tiptop;
grant delete on xmdu_t to tiptop;
grant insert on xmdu_t to tiptop;

exit;
