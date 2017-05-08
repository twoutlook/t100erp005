/* 
================================================================================
檔案代號:stdj_t
檔案名稱:市場活動費用核銷明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stdj_t
(
stdjent       number(5)      ,/* 企業編號 */
stdjunit       varchar2(10)      ,/* 應用組織 */
stdjsite       varchar2(10)      ,/* 營運據點 */
stdjdocno       varchar2(20)      ,/* 單據編號 */
stdjseq       number(10,0)      ,/* 項次 */
stdj001       varchar2(20)      ,/* 申請單號 */
stdj002       number(10,0)      ,/* 申請項次 */
stdj003       varchar2(10)      ,/* 對象類型 */
stdj004       varchar2(10)      ,/* 經銷商 */
stdj005       varchar2(10)      ,/* 網點編號 */
stdj006       varchar2(10)      ,/* 費用編號 */
stdj007       varchar2(10)      ,/* 價款類型 */
stdj008       varchar2(10)      ,/* 幣別 */
stdj009       varchar2(10)      ,/* 稅別 */
stdj010       number(20,6)      ,/* 申請金額 */
stdj011       number(20,6)      ,/* 核銷金額 */
stdj012       date      ,/* 起始日期 */
stdj013       date      ,/* 截止日期 */
stdj014       number(10,0)      ,/* 結算會計期 */
stdj015       varchar2(20)      ,/* 合約編號 */
stdj016       varchar2(10)      ,/* 經營方式 */
stdj017       varchar2(10)      ,/* 結算方式 */
stdj018       varchar2(10)      ,/* 結算類型 */
stdj019       varchar2(10)      ,/* 結算中心 */
stdj020       varchar2(30)      ,/* 促銷方案 */
stdj021       varchar2(10)      ,/* 銷售範圍 */
stdj022       varchar2(10)      ,/* 銷售組織 */
stdj023       varchar2(10)      ,/* 銷售渠道 */
stdj024       varchar2(10)      ,/* 產品組 */
stdj025       varchar2(10)      ,/* 辦事處 */
stdj026       varchar2(80)      ,/* 備註 */
stdjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stdj_t add constraint stdj_pk primary key (stdjent,stdjdocno,stdjseq) enable validate;

create unique index stdj_pk on stdj_t (stdjent,stdjdocno,stdjseq);

grant select on stdj_t to tiptop;
grant update on stdj_t to tiptop;
grant delete on stdj_t to tiptop;
grant insert on stdj_t to tiptop;

exit;
