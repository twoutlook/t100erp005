/* 
================================================================================
檔案代號:xmfl_t
檔案名稱:銷售折扣合約單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfl_t
(
xmflent       number(5)      ,/* 企業編號 */
xmflsite       varchar2(10)      ,/* 營運據點 */
xmfldocno       varchar2(20)      ,/* 合約單號 */
xmflseq       number(10,0)      ,/* 項次 */
xmfl001       varchar2(10)      ,/* 類型 */
xmfl002       varchar2(40)      ,/* 資料編號 */
xmfl003       varchar2(256)      ,/* 產品特徵 */
xmfl004       varchar2(40)      ,/* 客戶料號 */
xmfl005       varchar2(10)      ,/* 折扣方式 */
xmfl006       varchar2(10)      ,/* 計價單位 */
xmfl007       number(20,6)      ,/* 單價 */
xmfl008       number(20,6)      ,/* 折扣率 */
xmfl009       varchar2(1)      ,/* 分段折扣否 */
xmfl010       date      ,/* 最近結算日期 */
xmfl011       date      ,/* 結算起始日期 */
xmfl012       date      ,/* 結算截止日期 */
xmfl020       varchar2(255)      ,/* 備註 */
xmflud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmflud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmflud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmflud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmflud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmflud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmflud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmflud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmflud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmflud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmflud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmflud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmflud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmflud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmflud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmflud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmflud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmflud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmflud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmflud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmflud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmflud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmflud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmflud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmflud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmflud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmflud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmflud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmflud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmflud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfl_t add constraint xmfl_pk primary key (xmflent,xmfldocno,xmflseq) enable validate;

create unique index xmfl_pk on xmfl_t (xmflent,xmfldocno,xmflseq);

grant select on xmfl_t to tiptop;
grant update on xmfl_t to tiptop;
grant delete on xmfl_t to tiptop;
grant insert on xmfl_t to tiptop;

exit;
