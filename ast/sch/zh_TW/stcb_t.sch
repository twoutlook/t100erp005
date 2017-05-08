/* 
================================================================================
檔案代號:stcb_t
檔案名稱:分銷合約申請費用設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcb_t
(
stcbent       number(5)      ,/* 企業編號 */
stcbsite       varchar2(10)      ,/* 營運據點 */
stcbunit       varchar2(10)      ,/* 應用組織 */
stcbdocno       varchar2(20)      ,/* 單據編號 */
stcbseq       number(10,0)      ,/* 項次 */
stcb001       varchar2(20)      ,/* 合約編號 */
stcb002       varchar2(10)      ,/* 費用編號 */
stcb003       varchar2(10)      ,/* 會計期間 */
stcb004       varchar2(10)      ,/* 價款類別 */
stcb005       varchar2(10)      ,/* 計算類型 */
stcb006       varchar2(10)      ,/* 費用週期 */
stcb007       varchar2(10)      ,/* 費用週期方式 */
stcb008       varchar2(10)      ,/* 條件基準 */
stcb009       varchar2(10)      ,/* 計算基準 */
stcb010       number(20,6)      ,/* 費用淨額 */
stcb011       number(20,6)      ,/* 費用比率 */
stcb012       varchar2(10)      ,/* 保底否 */
stcb013       number(20,6)      ,/* 保底金額 */
stcb014       number(20,6)      ,/* 保底扣率 */
stcb015       varchar2(10)      ,/* 分量扣點 */
stcb016       date      ,/* 生效日期 */
stcb017       date      ,/* 失效日期 */
stcb018       date      ,/* 下次計算日 */
stcb019       date      ,/* 費用開始日期 */
stcb020       date      ,/* 費用截止日期 */
stcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stcb021       varchar2(1)      /* 是否參與現金折扣 */
);
alter table stcb_t add constraint stcb_pk primary key (stcbent,stcbdocno,stcbseq) enable validate;

create unique index stcb_pk on stcb_t (stcbent,stcbdocno,stcbseq);

grant select on stcb_t to tiptop;
grant update on stcb_t to tiptop;
grant delete on stcb_t to tiptop;
grant insert on stcb_t to tiptop;

exit;
